package forex.genetic.entities;

import java.util.Date;

import forex.genetic.util.Constants.OperationType;

public class ParametroOperacionPeriodo {

	private int id, filtroPipsXSemana, filtroPipsXMes, filtroPipsXAnyo, filtroPipsTotales, cantidad, cantidadParalelas;
	private String firstOrder, secondOrder;
	private double pipsTotales, pipsParalelas, pipsAgrupadoMinutos, pipsAgrupadoHoras, pipsAgrupadoDias;
	private Date fechaInicial, fechaFinal, fecha;
	private OperationType tipoOperacion;

	public ParametroOperacionPeriodo(int filtroPipsXSemana, int filtroPipsXMes, int filtroPipsXAnyo,
			int filtroPipsTotales, String firstOrder, String secondOrder) {
		super();
		this.fecha = new Date();
		this.filtroPipsXSemana = filtroPipsXSemana;
		this.filtroPipsXMes = filtroPipsXMes;
		this.filtroPipsXAnyo = filtroPipsXAnyo;
		this.filtroPipsTotales = filtroPipsTotales;
		this.firstOrder = firstOrder;
		this.secondOrder = secondOrder;
	}

	public ParametroOperacionPeriodo() {
		super();
		this.fecha = new Date();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getFecha() {
		return fecha;
	}

	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}

	public int getFiltroPipsXMes() {
		return filtroPipsXMes;
	}

	public void setFiltroPipsXMes(int filtroPipsXMes) {
		this.filtroPipsXMes = filtroPipsXMes;
	}

	public int getFiltroPipsXAnyo() {
		return filtroPipsXAnyo;
	}

	public void setFiltroPipsXAnyo(int filtroPipsXAnyo) {
		this.filtroPipsXAnyo = filtroPipsXAnyo;
	}

	public int getFiltroPipsTotales() {
		return filtroPipsTotales;
	}

	public void setFiltroPipsTotales(int filtroPipsTotales) {
		this.filtroPipsTotales = filtroPipsTotales;
	}

	public int getCantidad() {
		return cantidad;
	}

	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}

	public String getFirstOrder() {
		return firstOrder;
	}

	public void setFirstOrder(String firstOrder) {
		this.firstOrder = firstOrder;
	}

	public String getSecondOrder() {
		return secondOrder;
	}

	public void setSecondOrder(String secondOrder) {
		this.secondOrder = secondOrder;
	}

	public double getPipsTotales() {
		return pipsTotales;
	}

	public void setPipsTotales(double pipsTotales) {
		this.pipsTotales = pipsTotales;
	}

	public Date getFechaInicial() {
		return fechaInicial;
	}

	public void setFechaInicial(Date fechaInicial) {
		this.fechaInicial = fechaInicial;
	}

	public Date getFechaFinal() {
		return fechaFinal;
	}

	public void setFechaFinal(Date fechaFinal) {
		this.fechaFinal = fechaFinal;
	}

	public int getCantidadParalelas() {
		return cantidadParalelas;
	}

	public void setCantidadParalelas(int cantidadParalelas) {
		this.cantidadParalelas = cantidadParalelas;
	}

	public double getPipsParalelas() {
		return pipsParalelas;
	}

	public void setPipsParalelas(double pipsParalelas) {
		this.pipsParalelas = pipsParalelas;
	}

	public double getPipsAgrupadoMinutos() {
		return pipsAgrupadoMinutos;
	}

	public void setPipsAgrupadoMinutos(double pipsAgrupadoMinutos) {
		this.pipsAgrupadoMinutos = pipsAgrupadoMinutos;
	}

	public double getPipsAgrupadoHoras() {
		return pipsAgrupadoHoras;
	}

	public void setPipsAgrupadoHoras(double pipsAgrupadoHoras) {
		this.pipsAgrupadoHoras = pipsAgrupadoHoras;
	}

	public double getPipsAgrupadoDias() {
		return pipsAgrupadoDias;
	}

	public void setPipsAgrupadoDias(double pipsAgrupadoDias) {
		this.pipsAgrupadoDias = pipsAgrupadoDias;
	}

	public int getFiltroPipsXSemana() {
		return filtroPipsXSemana;
	}

	public void setFiltroPipsXSemana(int filtroPipsXSemana) {
		this.filtroPipsXSemana = filtroPipsXSemana;
	}

	public OperationType getTipoOperacion() {
		return tipoOperacion;
	}

	public void setTipoOperacion(OperationType tipoOperacion) {
		this.tipoOperacion = tipoOperacion;
	}

	public boolean isFiltroValido() {
		int countPositivos = 0;
		countPositivos += (filtroPipsXSemana >= 0) ? 1 : 0;
		countPositivos += (filtroPipsXMes >= 0) ? 1 : 0;
		countPositivos += (filtroPipsXAnyo >= 0) ? 1 : 0;
		countPositivos += (filtroPipsTotales >= 0) ? 1 : 0;
		return (countPositivos >= 3);
	}

	@Override
	public String toString() {
		return "ParametroOperacionPeriodo [id=" + id + ", filtroPipsXSemana=" + filtroPipsXSemana + ", filtroPipsXMes="
				+ filtroPipsXMes + ", filtroPipsXAnyo=" + filtroPipsXAnyo + ", filtroPipsTotales=" + filtroPipsTotales
				+ ", cantidad=" + cantidad + ", cantidadParalelas=" + cantidadParalelas + ", firstOrder=" + firstOrder
				+ ", secondOrder=" + secondOrder + ", pipsTotales=" + pipsTotales + ", pipsParalelas=" + pipsParalelas
				+ ", pipsAgrupadoMinutos=" + pipsAgrupadoMinutos + ", pipsAgrupadoHoras=" + pipsAgrupadoHoras
				+ ", pipsAgrupadoDias=" + pipsAgrupadoDias + ", fechaInicial=" + fechaInicial + ", fechaFinal="
				+ fechaFinal + ", fecha=" + fecha + ", tipoOperacion=" + tipoOperacion + "]";
	}

}
