Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jun 2013 23:34:35 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:58575 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835129Ab3FDVcBUcMrk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jun 2013 23:32:01 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 6A1065A7052;
        Wed,  5 Jun 2013 00:32:00 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id VRi0TO2tv4Ms; Wed,  5 Jun 2013 00:31:55 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp4.welho.com (Postfix) with ESMTP id 3302F5BC011;
        Wed,  5 Jun 2013 00:31:54 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 4/6] staging: octeon-usb: cvmx-usbcx-defs.h: avoid long lines in comments
Date:   Wed,  5 Jun 2013 00:31:33 +0300
Message-Id: <1370381495-3358-5-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1370381495-3358-1-git-send-email-aaro.koskinen@iki.fi>
References: <1370381495-3358-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Format all comments (except license text) to fit to 80 column terminals.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/staging/octeon-usb/cvmx-usbcx-defs.h |  679 ++++++++++++++------------
 1 file changed, 380 insertions(+), 299 deletions(-)

diff --git a/drivers/staging/octeon-usb/cvmx-usbcx-defs.h b/drivers/staging/octeon-usb/cvmx-usbcx-defs.h
index 56cc373..96d1e7e 100644
--- a/drivers/staging/octeon-usb/cvmx-usbcx-defs.h
+++ b/drivers/staging/octeon-usb/cvmx-usbcx-defs.h
@@ -213,13 +213,15 @@
  *
  * Device All Endpoints Interrupt Register (DAINT)
  *
- * When a significant event occurs on an endpoint, a Device All Endpoints Interrupt register
- * interrupts the application using the Device OUT Endpoints Interrupt bit or Device IN Endpoints
- * Interrupt bit of the Core Interrupt register (GINTSTS.OEPInt or GINTSTS.IEPInt, respectively).
- * There is one interrupt bit per endpoint, up to a maximum of 16 bits for OUT endpoints and 16
- * bits for IN endpoints. For a bidirectional endpoint, the corresponding IN and OUT interrupt
- * bits are used. Bits in this register are set and cleared when the application sets and clears
- * bits in the corresponding Device Endpoint-n Interrupt register (DIEPINTn/DOEPINTn).
+ * When a significant event occurs on an endpoint, a Device All Endpoints
+ * Interrupt register interrupts the application using the Device OUT Endpoints
+ * Interrupt bit or Device IN Endpoints Interrupt bit of the Core Interrupt
+ * register (GINTSTS.OEPInt or GINTSTS.IEPInt, respectively). There is one
+ * interrupt bit per endpoint, up to a maximum of 16 bits for OUT endpoints and
+ * 16 bits for IN endpoints. For a bidirectional endpoint, the corresponding IN
+ * and OUT interrupt bits are used. Bits in this register are set and cleared
+ * when the application sets and clears bits in the corresponding Device
+ * Endpoint-n Interrupt register (DIEPINTn/DOEPINTn).
  */
 union cvmx_usbcx_daint {
 	uint32_t u32;
@@ -251,9 +253,10 @@ typedef union cvmx_usbcx_daint cvmx_usbcx_daint_t;
  *
  * Device All Endpoints Interrupt Mask Register (DAINTMSK)
  *
- * The Device Endpoint Interrupt Mask register works with the Device Endpoint Interrupt register
- * to interrupt the application when an event occurs on a device endpoint. However, the Device
- * All Endpoints Interrupt (DAINT) register bit corresponding to that interrupt will still be set.
+ * The Device Endpoint Interrupt Mask register works with the Device Endpoint
+ * Interrupt register to interrupt the application when an event occurs on a
+ * device endpoint. However, the Device All Endpoints Interrupt (DAINT) register
+ * bit corresponding to that interrupt will still be set.
  * Mask Interrupt: 1'b0 Unmask Interrupt: 1'b1
  */
 union cvmx_usbcx_daintmsk {
@@ -286,8 +289,9 @@ typedef union cvmx_usbcx_daintmsk cvmx_usbcx_daintmsk_t;
  *
  * Device Configuration Register (DCFG)
  *
- * This register configures the core in Device mode after power-on or after certain control
- * commands or enumeration. Do not make changes to this register after initial programming.
+ * This register configures the core in Device mode after power-on or after
+ * certain control commands or enumeration. Do not make changes to this register
+ * after initial programming.
  */
 union cvmx_usbcx_dcfg {
 	uint32_t u32;
@@ -301,10 +305,10 @@ union cvmx_usbcx_dcfg {
 	 *	there is a match or when the counter expires. The width of this
 	 *	counter depends on the depth of the Token Queue.
 	 * @perfrint: Periodic Frame Interval (PerFrInt)
-	 *	Indicates the time within a (micro)frame at which the application
-	 *	must be notified using the End Of Periodic Frame Interrupt. This
-	 *	can be used to determine if all the isochronous traffic for that
-	 *	(micro)frame is complete.
+	 *	Indicates the time within a (micro)frame at which the
+	 *	application must be notified using the End Of Periodic Frame
+	 *	Interrupt. This can be used to determine if all the isochronous
+	 *	traffic for that (micro)frame is complete.
 	 *	* 2'b00: 80% of the (micro)frame interval
 	 *	* 2'b01: 85%
 	 *	* 2'b10: 90%
@@ -324,8 +328,8 @@ union cvmx_usbcx_dcfg {
 	 *	the NAK and STALL bits for the endpoint in the Device
 	 *	Endpoint Control register.
 	 * @devspd: Device Speed (DevSpd)
-	 *	Indicates the speed at which the application requires the core to
-	 *	enumerate, or the maximum speed the application can support.
+	 *	Indicates the speed at which the application requires the core
+	 *	to enumerate, or the maximum speed the application can support.
 	 *	However, the actual bus speed is determined only after the
 	 *	chirp sequence is completed, and is based on the speed of the
 	 *	USB host to which the core is connected. See "Device
@@ -409,14 +413,14 @@ union cvmx_usbcx_dctl {
 	 *	* 1'b0: A handshake is sent out based on the data availability
 	 *	in the transmit FIFO.
 	 *	* 1'b1: A NAK handshake is sent out on all non-periodic IN
-	 *	endpoints, irrespective of the data availability in the transmit
-	 *	FIFO.
+	 *	endpoints, irrespective of the data availability in the
+	 *	transmit FIFO.
 	 * @sftdiscon: Soft Disconnect (SftDiscon)
 	 *	The application uses this bit to signal the O2P USB core to do a
-	 *	soft disconnect. As long as this bit is set, the host will not see
-	 *	that the device is connected, and the device will not receive
-	 *	signals on the USB. The core stays in the disconnected state
-	 *	until the application clears this bit.
+	 *	soft disconnect. As long as this bit is set, the host will not
+	 *	see that the device is connected, and the device will not
+	 *	receive signals on the USB. The core stays in the disconnected
+	 *	state until the application clears this bit.
 	 *	The minimum duration for which the core must keep this bit set
 	 *	is specified in Minimum Duration for Soft Disconnect  .
 	 *	* 1'b0: Normal operation. When this bit is cleared after a soft
@@ -430,8 +434,8 @@ union cvmx_usbcx_dctl {
 	 * @rmtwkupsig: Remote Wakeup Signaling (RmtWkUpSig)
 	 *	When the application sets this bit, the core initiates remote
 	 *	signaling to wake up the USB host.The application must set this
-	 *	bit to get the core out of Suspended state and must clear this bit
-	 *	after the core comes out of Suspended state.
+	 *	bit to get the core out of Suspended state and must clear this
+	 *	bit after the core comes out of Suspended state.
 	 */
 	struct cvmx_usbcx_dctl_s {
 		uint32_t reserved_12_31:20;
@@ -461,7 +465,8 @@ typedef union cvmx_usbcx_dctl cvmx_usbcx_dctl_t;
  *
  * Device IN Endpoint-n Control Register (DIEPCTLn)
  *
- * The application uses the register to control the behaviour of each logical endpoint other than endpoint 0.
+ * The application uses the register to control the behaviour of each logical
+ * endpoint other than endpoint 0.
  */
 union cvmx_usbcx_diepctlx {
 	uint32_t u32;
@@ -475,12 +480,12 @@ union cvmx_usbcx_diepctlx {
 	 *	* Transfer Completed
 	 * @epdis: Endpoint Disable (EPDis)
 	 *	The application sets this bit to stop transmitting data on an
-	 *	endpoint, even before the transfer for that endpoint is complete.
-	 *	The application must wait for the Endpoint Disabled interrupt
-	 *	before treating the endpoint as disabled. The core clears this bit
-	 *	before setting the Endpoint Disabled Interrupt. The application
-	 *	should set this bit only if Endpoint Enable is already set for this
-	 *	endpoint.
+	 *	endpoint, even before the transfer for that endpoint is
+	 *	complete. The application must wait for the Endpoint Disabled
+	 *	interrupt before treating the endpoint as disabled. The core
+	 *	clears this bit before setting the Endpoint Disabled Interrupt.
+	 *	The application should set this bit only if Endpoint Enable is
+	 *	already set for this endpoint.
 	 * @setd1pid: For Interrupt/BULK enpoints:
 	 *	Set DATA1 PID (SetD1PID)
 	 *	Writing to this field sets the Endpoint Data Pid (DPID) field in
@@ -512,16 +517,18 @@ union cvmx_usbcx_diepctlx {
 	 *	* Others: Specified Periodic TxFIFO number
 	 * @stall: STALL Handshake (Stall)
 	 *	For non-control, non-isochronous endpoints:
-	 *	The application sets this bit to stall all tokens from the USB host
-	 *	to this endpoint.  If a NAK bit, Global Non-Periodic IN NAK, or
-	 *	Global OUT NAK is set along with this bit, the STALL bit takes
-	 *	priority.  Only the application can clear this bit, never the core.
+	 *	The application sets this bit to stall all tokens from the USB
+	 *	host to this endpoint. If a NAK bit, Global Non-Periodic IN NAK,
+	 *	or Global OUT NAK is set along with this bit, the STALL bit
+	 *	takes priority. Only the application can clear this bit, never
+	 *	the core.
 	 *	For control endpoints:
-	 *	The application can only set this bit, and the core clears it, when
-	 *	a SETUP token i received for this endpoint.  If a NAK bit, Global
-	 *	Non-Periodic IN NAK, or Global OUT NAK is set along with this
-	 *	bit, the STALL bit takes priority.  Irrespective of this bit's setting,
-	 *	the core always responds to SETUP data packets with an ACK handshake.
+	 *	The application can only set this bit, and the core clears it,
+	 *	when a SETUP token i received for this endpoint. If a NAK bit,
+	 *	Global Non-Periodic IN NAK, or Global OUT NAK is set along with
+	 *	this bit, the STALL bit takes priority. Irrespective of this
+	 *	bit's setting, the core always responds to SETUP data packets
+	 *	with an ACK handshake.
 	 * @eptype: Endpoint Type (EPType)
 	 *	This is the transfer type supported by this logical endpoint.
 	 *	* 2'b00: Control
@@ -545,10 +552,10 @@ union cvmx_usbcx_diepctlx {
 	 * @dpid: For interrupt/bulk IN and OUT endpoints:
 	 *	Endpoint Data PID (DPID)
 	 *	Contains the PID of the packet to be received or transmitted on
-	 *	this endpoint.  The application should program the PID of the first
-	 *	packet to be received or transmitted on this endpoint, after the
-	 *	endpoint is activated.  Applications use the SetD1PID and
-	 *	SetD0PID fields of this register to program either DATA0 or
+	 *	this endpoint. The application should program the PID of the
+	 *	first packet to be received or transmitted on this endpoint,
+	 *	after the endpoint is activated. Applications use the SetD1PID
+	 *	and SetD0PID fields of this register to program either DATA0 or
 	 *	DATA1 PID.
 	 *	* 1'b0: DATA0
 	 *	* 1'b1: DATA1
@@ -628,10 +635,10 @@ union cvmx_usbcx_diepintx {
 	 * struct cvmx_usbcx_diepintx_s
 	 * @inepnakeff: IN Endpoint NAK Effective (INEPNakEff)
 	 *	Applies to periodic IN endpoints only.
-	 *	Indicates that the IN endpoint NAK bit set by the application has
-	 *	taken effect in the core. This bit can be cleared when the
-	 *	application clears the IN endpoint NAK by writing to
-	 *	DIEPCTLn.CNAK.
+	 *	Indicates that the IN endpoint NAK bit set by the
+	 *	application has taken effect in the core. This bit can
+	 *	be cleared when the application clears the IN endpoint
+	 *	NAK by writing to DIEPCTLn.CNAK.
 	 *	This interrupt indicates that the core has sampled the NAK bit
 	 *	set (either by the application or by the core).
 	 *	This interrupt does not necessarily mean that a NAK handshake
@@ -688,10 +695,11 @@ typedef union cvmx_usbcx_diepintx cvmx_usbcx_diepintx_t;
  *
  * Device IN Endpoint Common Interrupt Mask Register (DIEPMSK)
  *
- * This register works with each of the Device IN Endpoint Interrupt (DIEPINTn) registers
- * for all endpoints to generate an interrupt per IN endpoint. The IN endpoint interrupt
- * for a specific status in the DIEPINTn register can be masked by writing to the corresponding
- * bit in this register. Status bits are masked by default.
+ * This register works with each of the Device IN Endpoint Interrupt
+ * (DIEPINTn) registers for all endpoints to generate an interrupt per
+ * IN endpoint. The IN endpoint interrupt for a specific status in the
+ * DIEPINTn register can be masked by writing to the corresponding bit in
+ * this register. Status bits are masked by default.
  * Mask interrupt: 1'b0 Unmask interrupt: 1'b1
  */
 union cvmx_usbcx_diepmsk {
@@ -699,7 +707,8 @@ union cvmx_usbcx_diepmsk {
 	/**
 	 * struct cvmx_usbcx_diepmsk_s
 	 * @inepnakeffmsk: IN Endpoint NAK Effective Mask (INEPNakEffMsk)
-	 * @intknepmismsk: IN Token received with EP Mismatch Mask (INTknEPMisMsk)
+	 * @intknepmismsk: IN Token received with EP Mismatch Mask
+	 *		   (INTknEPMisMsk)
 	 * @intkntxfempmsk: IN Token Received When TxFIFO Empty Mask
 	 *	(INTknTXFEmpMsk)
 	 * @timeoutmsk: Timeout Condition Mask (TimeOUTMsk)
@@ -734,8 +743,10 @@ typedef union cvmx_usbcx_diepmsk cvmx_usbcx_diepmsk_t;
  * Device Endpoint-n Transfer Size Register (DIEPTSIZn)
  *
  * The application must modify this register before enabling the endpoint.
- * Once the endpoint is enabled using Endpoint Enable bit of the Device Endpoint-n Control registers (DIEPCTLn.EPEna/DOEPCTLn.EPEna),
- * the core modifies this register. The application can only read this register once the core has cleared the Endpoint Enable bit.
+ * Once the endpoint is enabled using Endpoint Enable bit of the Device
+ * Endpoint-n Control registers (DIEPCTLn.EPEna/DOEPCTLn.EPEna), the core
+ * modifies this register. The application can only read this register
+ * once the core has cleared the Endpoint Enable bit.
  * This register is used only for endpoints other than Endpoint 0.
  */
 union cvmx_usbcx_dieptsizx {
@@ -751,11 +762,11 @@ union cvmx_usbcx_dieptsizx {
 	 *	* 2'b01: 1 packet
 	 *	* 2'b10: 2 packets
 	 *	* 2'b11: 3 packets
-	 *	For non-periodic IN endpoints, this field is valid only in Internal
-	 *	DMA mode. It specifies the number of packets the core should
-	 *	fetch for an IN endpoint before it switches to the endpoint
-	 *	pointed to by the Next Endpoint field of the Device Endpoint-n
-	 *	Control register (DIEPCTLn.NextEp)
+	 *	For non-periodic IN endpoints, this field is valid only in
+	 *	Internal DMA mode. It specifies the number of packets the core
+	 *	should fetch for an IN endpoint before it switches to the
+	 *	endpoint pointed to by the Next Endpoint field of the Device
+	 *	Endpoint-n Control register (DIEPCTLn.NextEp)
 	 * @pktcnt: Packet Count (PktCnt)
 	 *	Indicates the total number of USB packets that constitute the
 	 *	Transfer Size amount of data for this endpoint.
@@ -765,8 +776,8 @@ union cvmx_usbcx_dieptsizx {
 	 *	This field contains the transfer size in bytes for the current
 	 *	endpoint.
 	 *	The core only interrupts the application after it has exhausted
-	 *	the transfer size amount of data. The transfer size can be set to
-	 *	the maximum packet size of the endpoint, to be interrupted at
+	 *	the transfer size amount of data. The transfer size can be set
+	 *	to the maximum packet size of the endpoint, to be interrupted at
 	 *	the end of each packet.
 	 *	IN Endpoints: The core decrements this field every time a
 	 *	packet from the external memory is written to the TxFIFO.
@@ -792,7 +803,8 @@ typedef union cvmx_usbcx_dieptsizx cvmx_usbcx_dieptsizx_t;
  *
  * Device OUT Endpoint-n Control Register (DOEPCTLn)
  *
- * The application uses the register to control the behaviour of each logical endpoint other than endpoint 0.
+ * The application uses the register to control the behaviour of each
+ * logical endpoint other than endpoint 0.
  */
 union cvmx_usbcx_doepctlx {
 	uint32_t u32;
@@ -810,12 +822,12 @@ union cvmx_usbcx_doepctlx {
 	 *	to be able to transfer SETUP data packets in memory.
 	 * @epdis: Endpoint Disable (EPDis)
 	 *	The application sets this bit to stop transmitting data on an
-	 *	endpoint, even before the transfer for that endpoint is complete.
-	 *	The application must wait for the Endpoint Disabled interrupt
-	 *	before treating the endpoint as disabled. The core clears this bit
-	 *	before setting the Endpoint Disabled Interrupt. The application
-	 *	should set this bit only if Endpoint Enable is already set for this
-	 *	endpoint.
+	 *	endpoint, even before the transfer for that endpoint
+	 *	is complete. The application must wait for the Endpoint Disabled
+	 *	interrupt before treating the endpoint as disabled. The core
+	 *	clears this bit before setting the Endpoint Disabled Interrupt.
+	 *	The application should set this bit only if Endpoint Enable is
+	 *	already set for this endpoint.
 	 * @setd1pid: For Interrupt/BULK enpoints:
 	 *	Set DATA1 PID (SetD1PID)
 	 *	Writing to this field sets the Endpoint Data Pid (DPID) field in
@@ -841,16 +853,17 @@ union cvmx_usbcx_doepctlx {
 	 *	A write to this bit clears the NAK bit for the endpoint.
 	 * @stall: STALL Handshake (Stall)
 	 *	For non-control, non-isochronous endpoints:
-	 *	The application sets this bit to stall all tokens from the USB host
-	 *	to this endpoint.  If a NAK bit, Global Non-Periodic IN NAK, or
-	 *	Global OUT NAK is set along with this bit, the STALL bit takes
-	 *	priority.  Only the application can clear this bit, never the core.
-	 *	For control endpoints:
-	 *	The application can only set this bit, and the core clears it, when
-	 *	a SETUP token i received for this endpoint.  If a NAK bit, Global
-	 *	Non-Periodic IN NAK, or Global OUT NAK is set along with this
-	 *	bit, the STALL bit takes priority.  Irrespective of this bit's setting,
-	 *	the core always responds to SETUP data packets with an ACK handshake.
+	 *	The application sets this bit to stall all tokens from
+	 *	the USB host to this endpoint. If a NAK bit, Global Non-Periodic
+	 *	IN NAK, or Global OUT NAK is set along with this bit, the STALL
+	 *	bit takes priority. Only the application can clear this bit,
+	 *	never the core. For control endpoints:
+	 *	The application can only set this bit, and the core clears it,
+	 *	when a SETUP token i received for this endpoint. If a NAK bit,
+	 *	Global Non-Periodic IN NAK, or Global OUT NAK is set along with
+	 *	this bit, the STALL bit takes priority. Irrespective of this
+	 *	bit's setting, the core always responds to SETUP data packets
+	 *	with an ACK handshake.
 	 * @snp: Snoop Mode (Snp)
 	 *	This bit configures the endpoint to Snoop mode.  In Snoop mode,
 	 *	the core does not check the correctness of OUT packets before
@@ -874,10 +887,10 @@ union cvmx_usbcx_doepctlx {
 	 * @dpid: For interrupt/bulk IN and OUT endpoints:
 	 *	Endpoint Data PID (DPID)
 	 *	Contains the PID of the packet to be received or transmitted on
-	 *	this endpoint.  The application should program the PID of the first
-	 *	packet to be received or transmitted on this endpoint, after the
-	 *	endpoint is activated.  Applications use the SetD1PID and
-	 *	SetD0PID fields of this register to program either DATA0 or
+	 *	this endpoint.  The application should program the PID of the
+	 *	first packet to be received or transmitted on this endpoint,
+	 *	after the endpoint is activated.  Applications use the SetD1PID
+	 *	and SetD0PID fields of this register to program either DATA0 or
 	 *	DATA1 PID.
 	 *	* 1'b0: DATA0
 	 *	* 1'b1: DATA1
@@ -935,13 +948,16 @@ typedef union cvmx_usbcx_doepctlx cvmx_usbcx_doepctlx_t;
  *
  * Device Endpoint-n Interrupt Register (DOEPINTn)
  *
- * This register indicates the status of an endpoint with respect to USB- and AHB-related events.
- * The application must read this register when the OUT Endpoints Interrupt bit or IN Endpoints
- * Interrupt bit of the Core Interrupt register (GINTSTS.OEPInt or GINTSTS.IEPInt, respectively)
- * is set. Before the application can read this register, it must first read the Device All
- * Endpoints Interrupt (DAINT) register to get the exact endpoint number for the Device Endpoint-n
- * Interrupt register. The application must clear the appropriate bit in this register to clear the
- * corresponding bits in the DAINT and GINTSTS registers.
+ * This register indicates the status of an endpoint with respect to USB-
+ * and AHB-related events.
+ * The application must read this register when the OUT Endpoints
+ * Interrupt bit or IN Endpoints Interrupt bit of the Core Interrupt register
+ * (GINTSTS.OEPInt or GINTSTS.IEPInt, respectively) is set. Before the
+ * application can read this register, it must first read the Device All
+ * Endpoints Interrupt (DAINT) register to get the exact endpoint number for the
+ * Device Endpoint-n Interrupt register. The application must clear the
+ * appropriate bit in this register to clear the corresponding bits in the
+ * DAINT and GINTSTS registers.
  */
 union cvmx_usbcx_doepintx {
 	uint32_t u32;
@@ -956,8 +972,8 @@ union cvmx_usbcx_doepintx {
 	 *	Applies to control OUT endpoints only.
 	 *	Indicates that the SETUP phase for the control endpoint is
 	 *	complete and no more back-to-back SETUP packets were
-	 *	received for the current control transfer. On this interrupt, the
-	 *	application can decode the received SETUP data packet.
+	 *	received for the current control transfer. On this interrupt,
+	 *	the application can decode the received SETUP data packet.
 	 * @ahberr: AHB Error (AHBErr)
 	 *	This is generated only in Internal DMA mode when there is an
 	 *	AHB error during an AHB read/write. The application can read
@@ -993,10 +1009,11 @@ typedef union cvmx_usbcx_doepintx cvmx_usbcx_doepintx_t;
  *
  * Device OUT Endpoint Common Interrupt Mask Register (DOEPMSK)
  *
- * This register works with each of the Device OUT Endpoint Interrupt (DOEPINTn) registers
- * for all endpoints to generate an interrupt per OUT endpoint. The OUT endpoint interrupt
- * for a specific status in the DOEPINTn register can be masked by writing into the
- * corresponding bit in this register. Status bits are masked by default.
+ * This register works with each of the Device OUT Endpoint Interrupt
+ * (DOEPINTn) registers for all endpoints to generate an interrupt per
+ * OUT endpoint. The OUT endpoint interrupt for a specific status in the
+ * DOEPINTn register can be masked by writing into the corresponding bit
+ * in this register. Status bits are masked by default.
  * Mask interrupt: 1'b0 Unmask interrupt: 1'b1
  */
 union cvmx_usbcx_doepmsk {
@@ -1036,10 +1053,11 @@ typedef union cvmx_usbcx_doepmsk cvmx_usbcx_doepmsk_t;
  * Device Endpoint-n Transfer Size Register (DOEPTSIZn)
  *
  * The application must modify this register before enabling the endpoint.
- * Once the endpoint is enabled using Endpoint Enable bit of the Device Endpoint-n Control
- * registers (DOEPCTLn.EPEna/DOEPCTLn.EPEna), the core modifies this register. The application
- * can only read this register once the core has cleared the Endpoint Enable bit.
- * This register is used only for endpoints other than Endpoint 0.
+ * Once the endpoint is enabled using Endpoint Enable bit of the Device
+ * Endpoint-n Control registers (DOEPCTLn.EPEna/DOEPCTLn.EPEna), the core
+ * modifies this register. The application can only read this register once the
+ * core has cleared the Endpoint Enable bit. This register is used only for
+ * endpoints other than Endpoint 0.
  */
 union cvmx_usbcx_doeptsizx {
 	uint32_t u32;
@@ -1048,7 +1066,8 @@ union cvmx_usbcx_doeptsizx {
 	 * @mc: Multi Count (MC)
 	 *	Received Data PID (RxDPID)
 	 *	Applies to isochronous OUT endpoints only.
-	 *	This is the data PID received in the last packet for this endpoint.
+	 *	This is the data PID received in the last packet for this
+	 *	endpoint.
 	 *	2'b00: DATA0
 	 *	2'b01: DATA1
 	 *	2'b10: DATA2
@@ -1070,8 +1089,8 @@ union cvmx_usbcx_doeptsizx {
 	 *	This field contains the transfer size in bytes for the current
 	 *	endpoint.
 	 *	The core only interrupts the application after it has exhausted
-	 *	the transfer size amount of data. The transfer size can be set to
-	 *	the maximum packet size of the endpoint, to be interrupted at
+	 *	the transfer size amount of data. The transfer size can be set
+	 *	to the maximum packet size of the endpoint, to be interrupted at
 	 *	the end of each packet.
 	 *	OUT Endpoints: The core decrements this field every time a
 	 *	packet is read from the RxFIFO and written to the external
@@ -1098,9 +1117,10 @@ typedef union cvmx_usbcx_doeptsizx cvmx_usbcx_doeptsizx_t;
  *
  * Device Periodic Transmit FIFO-n Size Register (DPTXFSIZ)
  *
- * This register holds the memory start address of each periodic TxFIFO to implemented
- * in Device mode. Each periodic FIFO holds the data for one periodic IN endpoint.
- * This register is repeated for each periodic FIFO instantiated.
+ * This register holds the memory start address of each periodic TxFIFO
+ * to implemented in Device mode. Each periodic FIFO holds the data for
+ * one periodic IN endpoint.  This register is repeated for each periodic
+ * FIFO instantiated.
  */
 union cvmx_usbcx_dptxfsizx {
 	uint32_t u32;
@@ -1132,7 +1152,8 @@ typedef union cvmx_usbcx_dptxfsizx cvmx_usbcx_dptxfsizx_t;
  *
  * Device Status Register (DSTS)
  *
- * This register indicates the status of the core with respect to USB-related events.
+ * This register indicates the status of the core with respect to
+ * USB-related events.
  * It must be read on interrupts from Device All Interrupts (DAINT) register.
  */
 union cvmx_usbcx_dsts {
@@ -1148,8 +1169,9 @@ union cvmx_usbcx_dsts {
 	 *	(phy_rxvalid_i/phy_rxvldh_i or phy_rxactive_i is asserted for at
 	 *	least 2 ms, due to PHY error) seen on the UTMI+.
 	 *	Due to erratic errors, the O2P USB core goes into Suspended
-	 *	state and an interrupt is generated to the application with Early
-	 *	Suspend bit of the Core Interrupt register (GINTSTS.ErlySusp).
+	 *	state and an interrupt is generated to the application with
+	 *	Early Suspend bit of the Core Interrupt register
+	 *	(GINTSTS.ErlySusp).
 	 *	If the early suspend is asserted due to an erratic error, the
 	 *	application can only perform a soft disconnect recover.
 	 * @enumspd: Enumerated Speed (EnumSpd)
@@ -1161,8 +1183,8 @@ union cvmx_usbcx_dsts {
 	 *	* 2'b11: Full speed (PHY clock is running at 48 MHz)
 	 *	Low speed is not supported for devices using a UTMI+ PHY.
 	 * @suspsts: Suspend Status (SuspSts)
-	 *	In Device mode, this bit is set as long as a Suspend condition is
-	 *	detected on the USB. The core enters the Suspended state
+	 *	In Device mode, this bit is set as long as a Suspend condition
+	 *	is detected on the USB. The core enters the Suspended state
 	 *	when there is no activity on the phy_line_state_i signal for an
 	 *	extended period of time. The core comes out of the suspend:
 	 *	* When there is any activity on the phy_line_state_i signal
@@ -1192,10 +1214,11 @@ typedef union cvmx_usbcx_dsts cvmx_usbcx_dsts_t;
  *
  * Device IN Token Sequence Learning Queue Read Register 1 (DTKNQR1)
  *
- * The depth of the IN Token Sequence Learning Queue is specified for Device Mode IN Token
- * Sequence Learning Queue Depth. The queue is 4 bits wide to store the endpoint number.
- * A read from this register returns the first 5 endpoint entries of the IN Token Sequence
- * Learning Queue. When the queue is full, the new token is pushed into the queue and oldest
+ * The depth of the IN Token Sequence Learning Queue is specified for
+ * Device Mode IN Token Sequence Learning Queue Depth. The queue is 4 bits
+ * wide to store the endpoint number. A read from this register returns the
+ * first 5 endpoint entries of the IN Token Sequence Learning Queue. When
+ * the queue is full, the new token is pushed into the queue and oldest
  * token is discarded.
  */
 union cvmx_usbcx_dtknqr1 {
@@ -1235,7 +1258,8 @@ typedef union cvmx_usbcx_dtknqr1 cvmx_usbcx_dtknqr1_t;
  *
  * Device IN Token Sequence Learning Queue Read Register 2 (DTKNQR2)
  *
- * A read from this register returns the next 8 endpoint entries of the learning queue.
+ * A read from this register returns the next 8 endpoint entries of the
+ * learning queue.
  */
 union cvmx_usbcx_dtknqr2 {
 	uint32_t u32;
@@ -1267,7 +1291,8 @@ typedef union cvmx_usbcx_dtknqr2 cvmx_usbcx_dtknqr2_t;
  *
  * Device IN Token Sequence Learning Queue Read Register 3 (DTKNQR3)
  *
- * A read from this register returns the next 8 endpoint entries of the learning queue.
+ * A read from this register returns the next 8 endpoint entries of the
+ * learning queue.
  */
 union cvmx_usbcx_dtknqr3 {
 	uint32_t u32;
@@ -1299,7 +1324,8 @@ typedef union cvmx_usbcx_dtknqr3 cvmx_usbcx_dtknqr3_t;
  *
  * Device IN Token Sequence Learning Queue Read Register 4 (DTKNQR4)
  *
- * A read from this register returns the last 8 endpoint entries of the learning queue.
+ * A read from this register returns the last 8 endpoint entries of the
+ * learning queue.
  */
 union cvmx_usbcx_dtknqr4 {
 	uint32_t u32;
@@ -1331,12 +1357,14 @@ typedef union cvmx_usbcx_dtknqr4 cvmx_usbcx_dtknqr4_t;
  *
  * Core AHB Configuration Register (GAHBCFG)
  *
- * This register can be used to configure the core after power-on or a change in mode of operation.
- * This register mainly contains AHB system-related configuration parameters. The AHB is the processor
- * interface to the O2P USB core. In general, software need not know about this interface except to
- * program the values as specified.
+ * This register can be used to configure the core after power-on or
+ * a change in mode of operation. This register mainly contains AHB
+ * system-related configuration parameters. The AHB is the processor
+ * interface to the O2P USB core. In general, software need not know about
+ * this interface except to program the values as specified.
  *
- * The application must program this register as part of the O2P USB core initialization.
+ * The application must program this register as part of the O2P USB
+ * core initialization.
  * Do not change this register after the initial programming.
  */
 union cvmx_usbcx_gahbcfg {
@@ -1369,8 +1397,8 @@ union cvmx_usbcx_gahbcfg {
 	 * @glblintrmsk: Global Interrupt Mask (GlblIntrMsk)
 	 *	Software should set this field to 0x1.
 	 *	The application uses this bit to mask  or unmask the interrupt
-	 *	line assertion to itself. Irrespective of this bit's setting, the
-	 *	interrupt status registers are updated by the core.
+	 *	line assertion to itself. Irrespective of this bit's setting,
+	 *	the interrupt status registers are updated by the core.
 	 *	* 1'b0: Mask the interrupt assertion to the application.
 	 *	* 1'b1: Unmask the interrupt assertion to the application.
 	 */
@@ -1611,7 +1639,8 @@ union cvmx_usbcx_ghwcfg4 {
 	uint32_t u32;
 	/**
 	 * struct cvmx_usbcx_ghwcfg4_s
-	 * @numdevmodinend: Enable dedicatd transmit FIFO for device IN endpoints.
+	 * @numdevmodinend: Enable dedicatd transmit FIFO for device IN
+	 *		    endpoints.
 	 * @endedtrfifo: Enable dedicatd transmit FIFO for device IN endpoints.
 	 * @sessendfltr: "session_end" Filter Enabled (SessEndFltr)
 	 *	* 1'b0: No filter
@@ -1731,9 +1760,10 @@ typedef union cvmx_usbcx_ghwcfg4 cvmx_usbcx_ghwcfg4_t;
  *
  * Core Interrupt Mask Register (GINTMSK)
  *
- * This register works with the Core Interrupt register to interrupt the application.
- * When an interrupt bit is masked, the interrupt associated with that bit will not be generated.
- * However, the Core Interrupt (GINTSTS) register bit corresponding to that interrupt will still be set.
+ * This register works with the Core Interrupt register to interrupt the
+ * application. When an interrupt bit is masked, the interrupt associated
+ * with that bit will not be generated. However, the Core Interrupt
+ * (GINTSTS) register bit corresponding to that interrupt will still be set.
  * Mask interrupt: 1'b0, Unmask interrupt: 1'b1
  */
 union cvmx_usbcx_gintmsk {
@@ -1753,7 +1783,8 @@ union cvmx_usbcx_gintmsk {
 	 * @incomplpmsk: Incomplete Periodic Transfer Mask (incomplPMsk)
 	 *	Incomplete Isochronous OUT Transfer Mask
 	 *	(incompISOOUTMsk)
-	 * @incompisoinmsk: Incomplete Isochronous IN Transfer Mask (incompISOINMsk)
+	 * @incompisoinmsk: Incomplete Isochronous IN Transfer Mask
+	 *		    (incompISOINMsk)
 	 * @oepintmsk: OUT Endpoints Interrupt Mask (OEPIntMsk)
 	 * @inepintmsk: IN Endpoints Interrupt Mask (INEPIntMsk)
 	 * @epmismsk: Endpoint Mismatch Interrupt Mask (EPMisMsk)
@@ -1768,7 +1799,8 @@ union cvmx_usbcx_gintmsk {
 	 * @ulpickintmsk: ULPI Carkit Interrupt Mask (ULPICKINTMsk)
 	 *	I2C Carkit Interrupt Mask (I2CCKINTMsk)
 	 * @goutnakeffmsk: Global OUT NAK Effective Mask (GOUTNakEffMsk)
-	 * @ginnakeffmsk: Global Non-Periodic IN NAK Effective Mask (GINNakEffMsk)
+	 * @ginnakeffmsk: Global Non-Periodic IN NAK Effective Mask
+	 *	          (GINNakEffMsk)
 	 * @nptxfempmsk: Non-Periodic TxFIFO Empty Mask (NPTxFEmpMsk)
 	 * @rxflvlmsk: Receive FIFO Non-Empty Mask (RxFLvlMsk)
 	 * @sofmsk: Start of (micro)Frame Mask (SofMsk)
@@ -1824,12 +1856,15 @@ typedef union cvmx_usbcx_gintmsk cvmx_usbcx_gintmsk_t;
  *
  * Core Interrupt Register (GINTSTS)
  *
- * This register interrupts the application for system-level events in the current mode of operation
- * (Device mode or Host mode). It is shown in Interrupt. Some of the bits in this register are valid only in Host mode,
- * while others are valid in Device mode only. This register also indicates the current mode of operation.
- * In order to clear the interrupt status bits of type R_SS_WC, the application must write 1'b1 into the bit.
- * The FIFO status interrupts are read only; once software reads from or writes to the FIFO while servicing these
- * interrupts, FIFO interrupt conditions are cleared automatically.
+ * This register interrupts the application for system-level events in
+ * the current mode of operation (Device mode or Host mode). It is shown in
+ * Interrupt. Some of the bits in this register are valid only in Host mode,
+ * while others are valid in Device mode only. This register also indicates
+ * the current mode of operation.  In order to clear the interrupt status
+ * bits of type R_SS_WC, the application must write 1'b1 into the bit.
+ * The FIFO status interrupts are read only; once software reads from or
+ * writes to the FIFO while servicing these interrupts, FIFO interrupt
+ * conditions are cleared automatically.
  */
 union cvmx_usbcx_gintsts {
 	uint32_t u32;
@@ -1842,7 +1877,8 @@ union cvmx_usbcx_gintsts {
 	 *	For more information on how to use this interrupt, see "Partial
 	 *	Power-Down and Clock Gating Programming Model" on
 	 *	page 353.
-	 * @sessreqint: Session Request/New Session Detected Interrupt (SessReqInt)
+	 * @sessreqint: Session Request/New Session Detected Interrupt
+	 *		(SessReqInt)
 	 *	In Host mode, this interrupt is asserted when a session request
 	 *	is detected from the device. In Device mode, this interrupt is
 	 *	asserted when the utmiotg_bvalid signal goes high.
@@ -1862,27 +1898,27 @@ union cvmx_usbcx_gintsts {
 	 *	bit in the Core AHB Configuration register
 	 *	(GAHBCFG.PTxFEmpLvl).
 	 * @hchint: Host Channels Interrupt (HChInt)
-	 *	The core sets this bit to indicate that an interrupt is pending on
-	 *	one of the channels of the core (in Host mode). The application
-	 *	must read the Host All Channels Interrupt (HAINT) register to
-	 *	determine the exact number of the channel on which the
-	 *	interrupt occurred, and then read the corresponding Host
+	 *	The core sets this bit to indicate that an interrupt is pending
+	 *	on one of the channels of the core (in Host mode). The
+	 *	application must read the Host All Channels Interrupt (HAINT)
+	 *	register to determine the exact number of the channel on which
+	 *	the interrupt occurred, and then read the corresponding Host
 	 *	Channel-n Interrupt (HCINTn) register to determine the exact
 	 *	cause of the interrupt. The application must clear the
 	 *	appropriate status bit in the HCINTn register to clear this bit.
 	 * @prtint: Host Port Interrupt (PrtInt)
-	 *	The core sets this bit to indicate a change in port status of one
-	 *	of the O2P USB core ports in Host mode. The application must
+	 *	The core sets this bit to indicate a change in port status of
+	 *	one of the O2P USB core ports in Host mode. The application must
 	 *	read the Host Port Control and Status (HPRT) register to
 	 *	determine the exact event that caused this interrupt. The
-	 *	application must clear the appropriate status bit in the Host Port
-	 *	Control and Status register to clear this bit.
+	 *	application must clear the appropriate status bit in the Host
+	 *	Port Control and Status register to clear this bit.
 	 * @fetsusp: Data Fetch Suspended (FetSusp)
-	 *	This interrupt is valid only in DMA mode. This interrupt indicates
-	 *	that the core has stopped fetching data for IN endpoints due to
-	 *	the unavailability of TxFIFO space or Request Queue space.
-	 *	This interrupt is used by the application for an endpoint
-	 *	mismatch algorithm.
+	 *	This interrupt is valid only in DMA mode. This interrupt
+	 *	indicates that the core has stopped fetching data for IN
+	 *	endpoints due to the unavailability of TxFIFO space or Request
+	 *	Queue space. This interrupt is used by the application for an
+	 *	endpoint mismatch algorithm.
 	 * @incomplp: Incomplete Periodic Transfer (incomplP)
 	 *	In Host mode, the core sets this interrupt bit when there are
 	 *	incomplete periodic transactions still pending which are
@@ -1894,13 +1930,14 @@ union cvmx_usbcx_gintsts {
 	 *	interrupt is asserted along with the End of Periodic Frame
 	 *	Interrupt (EOPF) bit in this register.
 	 * @incompisoin: Incomplete Isochronous IN Transfer (incompISOIN)
-	 *	The core sets this interrupt to indicate that there is at least one
-	 *	isochronous IN endpoint on which the transfer is not completed
-	 *	in the current microframe. This interrupt is asserted along with
-	 *	the End of Periodic Frame Interrupt (EOPF) bit in this register.
+	 *	The core sets this interrupt to indicate that there is at least
+	 *	one isochronous IN endpoint on which the transfer is not
+	 *	completed in the current microframe. This interrupt is asserted
+	 *	along with the End of Periodic Frame Interrupt (EOPF) bit in
+	 *	this register.
 	 * @oepint: OUT Endpoints Interrupt (OEPInt)
-	 *	The core sets this bit to indicate that an interrupt is pending on
-	 *	one of the OUT endpoints of the core (in Device mode). The
+	 *	The core sets this bit to indicate that an interrupt is pending
+	 *	on one of the OUT endpoints of the core (in Device mode). The
 	 *	application must read the Device All Endpoints Interrupt
 	 *	(DAINT) register to determine the exact number of the OUT
 	 *	endpoint on which the interrupt occurred, and then read the
@@ -1909,8 +1946,8 @@ union cvmx_usbcx_gintsts {
 	 *	application must clear the appropriate status bit in the
 	 *	corresponding DOEPINTn register to clear this bit.
 	 * @iepint: IN Endpoints Interrupt (IEPInt)
-	 *	The core sets this bit to indicate that an interrupt is pending on
-	 *	one of the IN endpoints of the core (in Device mode). The
+	 *	The core sets this bit to indicate that an interrupt is pending
+	 *	on one of the IN endpoints of the core (in Device mode). The
 	 *	application must read the Device All Endpoints Interrupt
 	 *	(DAINT) register to determine the exact number of the IN
 	 *	endpoint on which the interrupt occurred, and then read the
@@ -1920,13 +1957,13 @@ union cvmx_usbcx_gintsts {
 	 *	corresponding DIEPINTn register to clear this bit.
 	 * @epmis: Endpoint Mismatch Interrupt (EPMis)
 	 *	Indicates that an IN token has been received for a non-periodic
-	 *	endpoint, but the data for another endpoint is present in the top
-	 *	of the Non-Periodic Transmit FIFO and the IN endpoint
+	 *	endpoint, but the data for another endpoint is present in the
+	 *	top of the Non-Periodic Transmit FIFO and the IN endpoint
 	 *	mismatch count programmed by the application has expired.
 	 * @eopf: End of Periodic Frame Interrupt (EOPF)
-	 *	Indicates that the period specified in the Periodic Frame Interval
-	 *	field of the Device Configuration register (DCFG.PerFrInt) has
-	 *	been reached in the current microframe.
+	 *	Indicates that the period specified in the Periodic Frame
+	 *	Interval field of the Device Configuration register
+	 *	(DCFG.PerFrInt) has been reached in the current microframe.
 	 * @isooutdrop: Isochronous OUT Packet Dropped Interrupt (ISOOutDrop)
 	 *	The core sets this bit when it fails to write an isochronous OUT
 	 *	packet into the RxFIFO because the RxFIFO doesn't have
@@ -1937,8 +1974,8 @@ union cvmx_usbcx_gintsts {
 	 *	complete. The application must read the Device Status (DSTS)
 	 *	register to obtain the enumerated speed.
 	 * @usbrst: USB Reset (USBRst)
-	 *	The core sets this bit to indicate that a reset is detected on the
-	 *	USB.
+	 *	The core sets this bit to indicate that a reset is detected on
+	 *	the USB.
 	 * @usbsusp: USB Suspend (USBSusp)
 	 *	The core sets this bit to indicate that a suspend was detected
 	 *	on the USB. The core enters the Suspended state when there
@@ -1982,17 +2019,17 @@ union cvmx_usbcx_gintsts {
 	 *	(FS), micro-SOF (HS), or Keep-Alive (LS) is transmitted on the
 	 *	USB. The application must write a 1 to this bit to clear the
 	 *	interrupt.
-	 *	In Device mode, in the core sets this bit to indicate that an SOF
-	 *	token has been received on the USB. The application can read
+	 *	In Device mode, in the core sets this bit to indicate that an
+	 *	SOF token has been received on the USB. The application can read
 	 *	the Device Status register to get the current (micro)frame
 	 *	number. This interrupt is seen only when the core is operating
 	 *	at either HS or FS.
 	 * @otgint: OTG Interrupt (OTGInt)
 	 *	The core sets this bit to indicate an OTG protocol event. The
 	 *	application must read the OTG Interrupt Status (GOTGINT)
-	 *	register to determine the exact event that caused this interrupt.
-	 *	The application must clear the appropriate status bit in the
-	 *	GOTGINT register to clear this bit.
+	 *	register to determine the exact event that caused this
+	 *	interrupt. The application must clear the appropriate status
+	 *	bit in the GOTGINT register to clear this bit.
 	 * @modemis: Mode Mismatch Interrupt (ModeMis)
 	 *	The core sets this bit when the application is trying to access:
 	 *	* A Host mode register, when the core is operating in Device
@@ -2056,7 +2093,8 @@ typedef union cvmx_usbcx_gintsts cvmx_usbcx_gintsts_t;
  *
  * Non-Periodic Transmit FIFO Size Register (GNPTXFSIZ)
  *
- * The application can program the RAM size and the memory start address for the Non-Periodic TxFIFO.
+ * The application can program the RAM size and the memory start address
+ * for the Non-Periodic TxFIFO.
  */
 union cvmx_usbcx_gnptxfsiz {
 	uint32_t u32;
@@ -2089,8 +2127,8 @@ typedef union cvmx_usbcx_gnptxfsiz cvmx_usbcx_gnptxfsiz_t;
  *
  * Non-Periodic Transmit FIFO/Queue Status Register (GNPTXSTS)
  *
- * This read-only register contains the free space information for the Non-Periodic TxFIFO and
- * the Non-Periodic Transmit Request Queue
+ * This read-only register contains the free space information for the
+ * Non-Periodic TxFIFO and the Non-Periodic Transmit Request Queue
  */
 union cvmx_usbcx_gnptxsts {
 	uint32_t u32;
@@ -2149,7 +2187,8 @@ typedef union cvmx_usbcx_gnptxsts cvmx_usbcx_gnptxsts_t;
  *
  * OTG Control and Status Register (GOTGCTL)
  *
- * The OTG Control and Status register controls the behavior and reflects the status of the OTG function of the core.:
+ * The OTG Control and Status register controls the behavior and reflects
+ * the status of the OTG function of the core.:
  */
 union cvmx_usbcx_gotgctl {
 	uint32_t u32;
@@ -2166,7 +2205,8 @@ union cvmx_usbcx_gotgctl {
 	 *	* 1'b0: A-session is not valid
 	 *	* 1'b1: A-session is valid
 	 * @dbnctime: Long/Short Debounce Time (DbncTime)
-	 *	In the present version of the core this bit will only read as '0'.
+	 *	In the present version of the core this bit will only read as
+	 *	'0'.
 	 * @conidsts: Connector ID Status (ConIDSts)
 	 *	Indicates the connector ID status on a connect event.
 	 *	* 1'b0: The O2P USB core is in A-device mode
@@ -2214,8 +2254,9 @@ typedef union cvmx_usbcx_gotgctl cvmx_usbcx_gotgctl_t;
  *
  * OTG Interrupt Register (GOTGINT)
  *
- * The application reads this register whenever there is an OTG interrupt and clears the bits in this register
- * to clear the OTG interrupt. It is shown in Interrupt .:
+ * The application reads this register whenever there is an OTG interrupt
+ * and clears the bits in this register to clear the OTG interrupt. It is shown
+ * in Interrupt .:
  */
 union cvmx_usbcx_gotgint {
 	uint32_t u32;
@@ -2224,15 +2265,21 @@ union cvmx_usbcx_gotgint {
 	 * @dbncedone: Debounce Done (DbnceDone)
 	 *	In the present version of the code this bit is tied to '0'.
 	 * @adevtoutchg: A-Device Timeout Change (ADevTOUTChg)
-	 *	Since O2P USB core is not HNP or SRP capable this bit is always 0x0.
+	 *	Since O2P USB core is not HNP or SRP capable this bit is always
+	 *	0x0.
 	 * @hstnegdet: Host Negotiation Detected (HstNegDet)
-	 *	Since O2P USB core is not HNP or SRP capable this bit is always 0x0.
-	 * @hstnegsucstschng: Host Negotiation Success Status Change (HstNegSucStsChng)
-	 *	Since O2P USB core is not HNP or SRP capable this bit is always 0x0.
+	 *	Since O2P USB core is not HNP or SRP capable this bit is always
+	 *	0x0.
+	 * @hstnegsucstschng: Host Negotiation Success Status Change
+	 *		      (HstNegSucStsChng)
+	 *	Since O2P USB core is not HNP or SRP capable this bit is always
+	 *	0x0.
 	 * @sesreqsucstschng: Session Request Success Status Change
-	 *	Since O2P USB core is not HNP or SRP capable this bit is always 0x0.
+	 *	Since O2P USB core is not HNP or SRP capable this bit is always
+	 *	0x0.
 	 * @sesenddet: Session End Detected (SesEndDet)
-	 *	Since O2P USB core is not HNP or SRP capable this bit is always 0x0.
+	 *	Since O2P USB core is not HNP or SRP capable this bit is always
+	 *	0x0.
 	 */
 	struct cvmx_usbcx_gotgint_s {
 		uint32_t reserved_20_31:12;
@@ -2261,7 +2308,8 @@ typedef union cvmx_usbcx_gotgint cvmx_usbcx_gotgint_t;
  *
  * Core Reset Register (GRSTCTL)
  *
- * The application uses this register to reset various hardware features inside the core.
+ * The application uses this register to reset various hardware features
+ * inside the core.
  */
 union cvmx_usbcx_grstctl {
 	uint32_t u32;
@@ -2291,14 +2339,14 @@ union cvmx_usbcx_grstctl {
 	 *	core is neither writing to the TxFIFO nor reading from the
 	 *	TxFIFO.
 	 *	The application must wait until the core clears this bit before
-	 *	performing any operations. This bit takes 8 clocks (of phy_clk or
-	 *	hclk, whichever is slower) to clear.
+	 *	performing any operations. This bit takes 8 clocks (of phy_clk
+	 *	or hclk, whichever is slower) to clear.
 	 * @rxfflsh: RxFIFO Flush (RxFFlsh)
 	 *	The application can flush the entire RxFIFO using this bit, but
 	 *	must first ensure that the core is not in the middle of a
 	 *	transaction.
-	 *	The application must only write to this bit after checking that the
-	 *	core is neither reading from the RxFIFO nor writing to the
+	 *	The application must only write to this bit after checking that
+	 *	the core is neither reading from the RxFIFO nor writing to the
 	 *	RxFIFO.
 	 *	The application must wait until the bit is cleared before
 	 *	performing any other operations. This bit will take 8 clocks
@@ -2312,8 +2360,8 @@ union cvmx_usbcx_grstctl {
 	 *	the subsequent SOF sent out by the core will have a
 	 *	(micro)frame number of 0.
 	 * @hsftrst: HClk Soft Reset (HSftRst)
-	 *	The application uses this bit to flush the control logic in the AHB
-	 *	Clock domain. Only AHB Clock Domain pipelines are reset.
+	 *	The application uses this bit to flush the control logic in the
+	 *	AHB Clock domain. Only AHB Clock Domain pipelines are reset.
 	 *	* FIFOs are not flushed with this bit.
 	 *	* All state machines in the AHB clock domain are reset to the
 	 *	Idle state after terminating the transactions on the AHB,
@@ -2326,9 +2374,9 @@ union cvmx_usbcx_grstctl {
 	 *	* Because interrupt status bits are not cleared, the application
 	 *	can get the status of any core events that occurred after it set
 	 *	this bit.
-	 *	This is a self-clearing bit that the core clears after all necessary
-	 *	logic is reset in the core. This may take several clocks,
-	 *	depending on the core's current state.
+	 *	This is a self-clearing bit that the core clears after all
+	 *	necessary logic is reset in the core. This may take several
+	 *	clocks, depending on the core's current state.
 	 * @csftrst: Core Soft Reset (CSftRst)
 	 *	Resets the hclk and phy_clock domains as follows:
 	 *	* Clears the interrupts and all the CSR registers except the
@@ -2353,14 +2401,14 @@ union cvmx_usbcx_grstctl {
 	 *	an AHB transfer. Any transactions on the USB are terminated
 	 *	immediately.
 	 *	The application can write to this bit any time it wants to reset
-	 *	the core. This is a self-clearing bit and the core clears this bit
-	 *	after all the necessary logic is reset in the core, which may take
-	 *	several clocks, depending on the current state of the core.
-	 *	Once this bit is cleared software should wait at least 3 PHY
-	 *	clocks before doing any access to the PHY domain
+	 *	the core. This is a self-clearing bit and the core clears this
+	 *	bit after all the necessary logic is reset in the core, which
+	 *	may take several clocks, depending on the current state of the
+	 *	core. Once this bit is cleared software should wait at least 3
+	 *	PHY clocks before doing any access to the PHY domain
 	 *	(synchronization delay). Software should also should check that
-	 *	bit 31 of this register is 1 (AHB Master is IDLE) before starting
-	 *	any operation.
+	 *	bit 31 of this register is 1 (AHB Master is IDLE) before
+	 *	starting any operation.
 	 *	Typically software reset is used during software development
 	 *	and also when you dynamically change the PHY selection bits
 	 *	in the USB configuration registers listed above. When you
@@ -2395,7 +2443,8 @@ typedef union cvmx_usbcx_grstctl cvmx_usbcx_grstctl_t;
  *
  * Receive FIFO Size Register (GRXFSIZ)
  *
- * The application can program the RAM size that must be allocated to the RxFIFO.
+ * The application can program the RAM size that must be allocated to
+ * the RxFIFO.
  */
 union cvmx_usbcx_grxfsiz {
 	uint32_t u32;
@@ -2425,10 +2474,13 @@ typedef union cvmx_usbcx_grxfsiz cvmx_usbcx_grxfsiz_t;
  *
  * Receive Status Debug Read Register, Device Mode (GRXSTSPD)
  *
- * A read to the Receive Status Read and Pop register returns and additionally pops the top data entry out of the RxFIFO.
- * This Description is only valid when the core is in Device Mode.  For Host Mode use USBC_GRXSTSPH instead.
- * NOTE: GRXSTSPH and GRXSTSPD are physically the same register and share the same offset in the O2P USB core.
- *       The offset difference shown in this document is for software clarity and is actually ignored by the
+ * A read to the Receive Status Read and Pop register returns and
+ * additionally pops the top data entry out of the RxFIFO.
+ * This Description is only valid when the core is in Device Mode.
+ * For Host Mode use USBC_GRXSTSPH instead.
+ * NOTE: GRXSTSPH and GRXSTSPD are physically the same register and share the
+ *	 same offset in the O2P USB core. The offset difference shown in this
+ *	 document is for software clarity and is actually ignored by the
  *       hardware.
  */
 union cvmx_usbcx_grxstspd {
@@ -2436,9 +2488,9 @@ union cvmx_usbcx_grxstspd {
 	/**
 	 * struct cvmx_usbcx_grxstspd_s
 	 * @fn: Frame Number (FN)
-	 *	This is the least significant 4 bits of the (micro)frame number in
-	 *	which the packet is received on the USB.  This field is supported
-	 *	only when the isochronous OUT endpoints are supported.
+	 *	This is the least significant 4 bits of the (micro)frame number
+	 *	in which the packet is received on the USB. This field is
+	 *	supported only when the isochronous OUT endpoints are supported.
 	 * @pktsts: Packet Status (PktSts)
 	 *	Indicates the status of the received packet
 	 *	* 4'b0001: Glogal OUT NAK (triggers an interrupt)
@@ -2480,10 +2532,13 @@ typedef union cvmx_usbcx_grxstspd cvmx_usbcx_grxstspd_t;
  *
  * Receive Status Read and Pop Register, Host Mode (GRXSTSPH)
  *
- * A read to the Receive Status Read and Pop register returns and additionally pops the top data entry out of the RxFIFO.
- * This Description is only valid when the core is in Host Mode.  For Device Mode use USBC_GRXSTSPD instead.
- * NOTE: GRXSTSPH and GRXSTSPD are physically the same register and share the same offset in the O2P USB core.
- *       The offset difference shown in this document is for software clarity and is actually ignored by the
+ * A read to the Receive Status Read and Pop register returns and
+ * additionally pops the top data entry out of the RxFIFO.
+ * This Description is only valid when the core is in Host Mode. For Device Mode
+ * use USBC_GRXSTSPD instead.
+ * NOTE: GRXSTSPH and GRXSTSPD are physically the same register and share the
+ *	 same offset in the O2P USB core. The offset difference shown in this
+ *	 document is for software clarity and is actually ignored by the
  *       hardware.
  */
 union cvmx_usbcx_grxstsph {
@@ -2530,20 +2585,23 @@ typedef union cvmx_usbcx_grxstsph cvmx_usbcx_grxstsph_t;
  *
  * Receive Status Debug Read Register, Device Mode (GRXSTSRD)
  *
- * A read to the Receive Status Debug Read register returns the contents of the top of the Receive FIFO.
- * This Description is only valid when the core is in Device Mode.  For Host Mode use USBC_GRXSTSRH instead.
- * NOTE: GRXSTSRH and GRXSTSRD are physically the same register and share the same offset in the O2P USB core.
- *       The offset difference shown in this document is for software clarity and is actually ignored by the
- *       hardware.
+ * A read to the Receive Status Debug Read register returns the contents
+ * of the top of the Receive FIFO.
+ * This Description is only valid when the core is in Device Mode. For Host Mode
+ * use USBC_GRXSTSRH instead.
+ * NOTE: GRXSTSRH and GRXSTSRD are physically the same register and share the
+ *	 same offset in the O2P USB core. The offset difference shown in this
+ *	 document is for software clarity and is actually ignored by the
+ *	 hardware.
  */
 union cvmx_usbcx_grxstsrd {
 	uint32_t u32;
 	/**
 	 * struct cvmx_usbcx_grxstsrd_s
 	 * @fn: Frame Number (FN)
-	 *	This is the least significant 4 bits of the (micro)frame number in
-	 *	which the packet is received on the USB.  This field is supported
-	 *	only when the isochronous OUT endpoints are supported.
+	 *	This is the least significant 4 bits of the (micro)frame number
+	 *	in which the packet is received on the USB. This field is
+	 *	supported only when the isochronous OUT endpoints are supported.
 	 * @pktsts: Packet Status (PktSts)
 	 *	Indicates the status of the received packet
 	 *	* 4'b0001: Glogal OUT NAK (triggers an interrupt)
@@ -2585,11 +2643,14 @@ typedef union cvmx_usbcx_grxstsrd cvmx_usbcx_grxstsrd_t;
  *
  * Receive Status Debug Read Register, Host Mode (GRXSTSRH)
  *
- * A read to the Receive Status Debug Read register returns the contents of the top of the Receive FIFO.
- * This Description is only valid when the core is in Host Mode.  For Device Mode use USBC_GRXSTSRD instead.
- * NOTE: GRXSTSRH and GRXSTSRD are physically the same register and share the same offset in the O2P USB core.
- *       The offset difference shown in this document is for software clarity and is actually ignored by the
- *       hardware.
+ * A read to the Receive Status Debug Read register returns the contents
+ * of the top of the Receive FIFO.
+ * This Description is only valid when the core is in Host Mode.
+ * For Device Mode use USBC_GRXSTSRD instead.
+ * NOTE: GRXSTSRH and GRXSTSRD are physically the same register and share the
+ *	 same offset in the O2P USB core. The offset difference shown in this
+ *	 document is for software clarity and is actually ignored by the
+ *	 hardware.
  */
 union cvmx_usbcx_grxstsrh {
 	uint32_t u32;
@@ -2635,13 +2696,15 @@ typedef union cvmx_usbcx_grxstsrh cvmx_usbcx_grxstsrh_t;
  *
  * Synopsys ID Register (GSNPSID)
  *
- * This is a read-only register that contains the release number of the core being used.
+ * This is a read-only register that contains the release number of the
+ * core being used.
  */
 union cvmx_usbcx_gsnpsid {
 	uint32_t u32;
 	/**
 	 * struct cvmx_usbcx_gsnpsid_s
-	 * @synopsysid: 0x4F54\<version\>A, release number of the core being used.
+	 * @synopsysid: 0x4F54\<version\>A, release number of the core being
+	 *		used.
 	 *	0x4F54220A => pass1.x,  0x4F54240A => pass2.x
 	 */
 	struct cvmx_usbcx_gsnpsid_s {
@@ -2662,9 +2725,11 @@ typedef union cvmx_usbcx_gsnpsid cvmx_usbcx_gsnpsid_t;
  *
  * Core USB Configuration Register (GUSBCFG)
  *
- * This register can be used to configure the core after power-on or a changing to Host mode or Device mode.
- * It contains USB and USB-PHY related configuration parameters. The application must program this register
- * before starting any transactions on either the AHB or the USB.
+ * This register can be used to configure the core after power-on or a
+ * changing to Host mode or Device mode.
+ * It contains USB and USB-PHY related configuration parameters. The
+ * application must program this register before starting any transactions
+ * on either the AHB or the USB.
  * Do not make changes to this register after the initial programming.
  */
 union cvmx_usbcx_gusbcfg {
@@ -2715,9 +2780,10 @@ union cvmx_usbcx_gusbcfg {
 	 *	vary from one PHY to another.
 	 *	The USB standard timeout value for high-speed operation is
 	 *	736 to 816 (inclusive) bit times. The USB standard timeout
-	 *	value for full-speed operation is 16 to 18 (inclusive) bit times.
-	 *	The application must program this field based on the speed of
-	 *	enumeration. The number of bit times added per PHY clock are:
+	 *	value for full-speed operation is 16 to 18 (inclusive) bit
+	 *	times. The application must program this field based on the
+	 *	speed of enumeration. The number of bit times added per PHY
+	 *	clock are:
 	 *	High-speed operation:
 	 *	* One 30-MHz PHY clock = 16 bit times
 	 *	* One 60-MHz PHY clock = 8 bit times
@@ -2756,11 +2822,13 @@ typedef union cvmx_usbcx_gusbcfg cvmx_usbcx_gusbcfg_t;
  *
  * Host All Channels Interrupt Register (HAINT)
  *
- * When a significant event occurs on a channel, the Host All Channels Interrupt register
- * interrupts the application using the Host Channels Interrupt bit of the Core Interrupt
- * register (GINTSTS.HChInt). This is shown in Interrupt . There is one interrupt bit per
- * channel, up to a maximum of 16 bits. Bits in this register are set and cleared when the
- * application sets and clears bits in the corresponding Host Channel-n Interrupt register.
+ * When a significant event occurs on a channel, the Host All Channels
+ * Interrupt register interrupts the application using the Host Channels
+ * Interrupt bit of the Core Interrupt register (GINTSTS.HChInt). This is
+ * shown in Interrupt . There is one interrupt bit per channel, up to a
+ * maximum of 16 bits. Bits in this register are set and cleared when the
+ * application sets and clears bits in the corresponding Host Channel-n
+ * Interrupt register.
  */
 union cvmx_usbcx_haint {
 	uint32_t u32;
@@ -2788,9 +2856,10 @@ typedef union cvmx_usbcx_haint cvmx_usbcx_haint_t;
  *
  * Host All Channels Interrupt Mask Register (HAINTMSK)
  *
- * The Host All Channel Interrupt Mask register works with the Host All Channel Interrupt
- * register to interrupt the application when an event occurs on a channel. There is one
- * interrupt mask bit per channel, up to a maximum of 16 bits.
+ * The Host All Channel Interrupt Mask register works with the Host
+ * All Channel Interrupt register to interrupt the application when an
+ * event occurs on a channel. There is one interrupt mask bit per channel,
+ * up to a maximum of 16 bits.
  * Mask interrupt: 1'b0 Unmask interrupt: 1'b1
  */
 union cvmx_usbcx_haintmsk {
@@ -2825,24 +2894,25 @@ union cvmx_usbcx_hccharx {
 	/**
 	 * struct cvmx_usbcx_hccharx_s
 	 * @chena: Channel Enable (ChEna)
-	 *	This field is set by the application and cleared by the OTG host.
+	 *	This field is set by the application and cleared by the OTG
+	 *	host.
 	 *	* 1'b0: Channel disabled
 	 *	* 1'b1: Channel enabled
 	 * @chdis: Channel Disable (ChDis)
-	 *	The application sets this bit to stop transmitting/receiving data
-	 *	on a channel, even before the transfer for that channel is
+	 *	The application sets this bit to stop transmitting/receiving
+	 *	data on a channel, even before the transfer for that channel is
 	 *	complete. The application must wait for the Channel Disabled
 	 *	interrupt before treating the channel as disabled.
 	 * @oddfrm: Odd Frame (OddFrm)
-	 *	This field is set (reset) by the application to indicate that the
-	 *	OTG host must perform a transfer in an odd (micro)frame. This
-	 *	field is applicable for only periodic (isochronous and interrupt)
-	 *	transactions.
+	 *	This field is set (reset) by the application to indicate that
+	 *	the OTG host must perform a transfer in an odd (micro)frame.
+	 *	This field is applicable for only periodic (isochronous and
+	 *	interrupt) transactions.
 	 *	* 1'b0: Even (micro)frame
 	 *	* 1'b1: Odd (micro)frame
 	 * @devaddr: Device Address (DevAddr)
-	 *	This field selects the specific device serving as the data source
-	 *	or sink.
+	 *	This field selects the specific device serving as the data
+	 *	source or sink.
 	 * @ec: Multi Count (MC) / Error Count (EC)
 	 *	When the Split Enable bit of the Host Channel-n Split Control
 	 *	register (HCSPLTn.SpltEna) is reset (1'b0), this field indicates
@@ -2865,8 +2935,8 @@ union cvmx_usbcx_hccharx {
 	 *	* 2'b10: Bulk
 	 *	* 2'b11: Interrupt
 	 * @lspddev: Low-Speed Device (LSpdDev)
-	 *	This field is set by the application to indicate that this channel is
-	 *	communicating to a low-speed device.
+	 *	This field is set by the application to indicate that
+	 *	this channel is communicating to a low-speed device.
 	 * @epdir: Endpoint Direction (EPDir)
 	 *	Indicates whether the transaction is IN or OUT.
 	 *	* 1'b0: OUT
@@ -2905,7 +2975,8 @@ typedef union cvmx_usbcx_hccharx cvmx_usbcx_hccharx_t;
  *
  * Host Configuration Register (HCFG)
  *
- * This register configures the core after power-on. Do not make changes to this register after initializing the host.
+ * This register configures the core after power-on. Do not make changes
+ * to this register after initializing the host.
  */
 union cvmx_usbcx_hcfg {
 	uint32_t u32;
@@ -2959,12 +3030,15 @@ typedef union cvmx_usbcx_hcfg cvmx_usbcx_hcfg_t;
  *
  * Host Channel-n Interrupt Register (HCINT)
  *
- * This register indicates the status of a channel with respect to USB- and AHB-related events.
- * The application must read this register when the Host Channels Interrupt bit of the Core Interrupt
- * register (GINTSTS.HChInt) is set. Before the application can read this register, it must first read
- * the Host All Channels Interrupt (HAINT) register to get the exact channel number for the Host Channel-n
- * Interrupt register. The application must clear the appropriate bit in this register to clear the
- * corresponding bits in the HAINT and GINTSTS registers.
+ * This register indicates the status of a channel with respect to USB-
+ * and AHB-related events.
+ * The application must read this register when the Host Channels
+ * Interrupt bit of the Core Interrupt register (GINTSTS.HChInt) is
+ * set. Before the application can read this register, it must first read
+ * the Host All Channels Interrupt (HAINT) register to get the exact channel
+ * number for the Host Channel-n Interrupt register. The application must
+ * clear the appropriate bit in this register to clear the corresponding
+ * bits in the HAINT and GINTSTS registers.
  */
 union cvmx_usbcx_hcintx {
 	uint32_t u32;
@@ -3015,7 +3089,8 @@ typedef union cvmx_usbcx_hcintx cvmx_usbcx_hcintx_t;
  *
  * Host Channel-n Interrupt Mask Register (HCINTMSKn)
  *
- * This register reflects the mask for each channel status described in the previous section.
+ * This register reflects the mask for each channel status described in the
+ * previous section.
  * Mask interrupt: 1'b0 Unmask interrupt: 1'b1
  */
 union cvmx_usbcx_hcintmskx {
@@ -3075,16 +3150,16 @@ union cvmx_usbcx_hcspltx {
 	 *	The application sets this field to request the OTG host to
 	 *	perform a complete split transaction.
 	 * @xactpos: Transaction Position (XactPos)
-	 *	This field is used to determine whether to send all, first, middle,
-	 *	or last payloads with each OUT transaction.
-	 *	* 2'b11: All. This is the entire data payload is of this transaction
-	 *	(which is less than or equal to 188 bytes).
-	 *	* 2'b10: Begin. This is the first data payload of this transaction
-	 *	(which is larger than 188 bytes).
+	 *	This field is used to determine whether to send all, first,
+	 *	middle, or last payloads with each OUT transaction.
+	 *	* 2'b11: All. This is the entire data payload is of this
+	 *	transaction (which is less than or equal to 188 bytes).
+	 *	* 2'b10: Begin. This is the first data payload of this
+	 *	transaction (which is larger than 188 bytes).
 	 *	* 2'b00: Mid. This is the middle payload of this transaction
 	 *	(which is larger than 188 bytes).
-	 *	* 2'b01: End. This is the last payload of this transaction (which
-	 *	is larger than 188 bytes).
+	 *	* 2'b01: End. This is the last payload of this transaction
+	 *	(which is larger than 188 bytes).
 	 * @hubaddr: Hub Address (HubAddr)
 	 *	This field holds the device address of the transaction
 	 *	translator's hub.
@@ -3124,8 +3199,8 @@ union cvmx_usbcx_hctsizx {
 	 *	Setting this field to 1 directs the host to do PING protocol.
 	 * @pid: PID (Pid)
 	 *	The application programs this field with the type of PID to use
-	 *	for the initial transaction. The host will maintain this field for the
-	 *	rest of the transfer.
+	 *	for the initial transaction. The host will maintain this field
+	 *	for the rest of the transfer.
 	 *	* 2'b00: DATA0
 	 *	* 2'b01: DATA2
 	 *	* 2'b10: DATA1
@@ -3140,8 +3215,8 @@ union cvmx_usbcx_hctsizx {
 	 * @xfersize: Transfer Size (XferSize)
 	 *	For an OUT, this field is the number of data bytes the host will
 	 *	send during the transfer.
-	 *	For an IN, this field is the buffer size that the application has
-	 *	reserved for the transfer. The application is expected to
+	 *	For an IN, this field is the buffer size that the application
+	 *	has reserved for the transfer. The application is expected to
 	 *	program this field as an integer multiple of the maximum packet
 	 *	size for IN transactions (periodic and non-periodic).
 	 */
@@ -3166,7 +3241,8 @@ typedef union cvmx_usbcx_hctsizx cvmx_usbcx_hctsizx_t;
  *
  * Host Frame Interval Register (HFIR)
  *
- * This register stores the frame interval information for the current speed to which the O2P USB core has enumerated.
+ * This register stores the frame interval information for the current
+ * speed to which the O2P USB core has enumerated.
  */
 union cvmx_usbcx_hfir {
 	uint32_t u32;
@@ -3220,8 +3296,8 @@ union cvmx_usbcx_hfnum {
 	 *	Indicates the amount of time remaining in the current
 	 *	microframe (HS) or frame (FS/LS), in terms of PHY clocks.
 	 *	This field decrements on each PHY clock. When it reaches
-	 *	zero, this field is reloaded with the value in the Frame Interval
-	 *	register and a new SOF is transmitted on the USB.
+	 *	zero, this field is reloaded with the value in the Frame
+	 *	Interval register and a new SOF is transmitted on the USB.
 	 * @frnum: Frame Number (FrNum)
 	 *	This field increments when a new SOF is transmitted on the
 	 *	USB, and is reset to 0 when it reaches 16'h3FFF.
@@ -3247,12 +3323,13 @@ typedef union cvmx_usbcx_hfnum cvmx_usbcx_hfnum_t;
  *
  * This register is available in both Host and Device modes.
  * Currently, the OTG Host supports only one port.
- * A single register holds USB port-related information such as USB reset, enable, suspend, resume,
- * connect status, and test mode for each port. The R_SS_WC bits in this register can trigger an
- * interrupt to the application through the Host Port Interrupt bit of the Core Interrupt
- * register (GINTSTS.PrtInt). On a Port Interrupt, the application must read this register and clear
- * the bit that caused the interrupt. For the R_SS_WC bits, the application must write a 1 to the bit
- * to clear the interrupt.
+ * A single register holds USB port-related information such as USB reset,
+ * enable, suspend, resume, connect status, and test mode for each port. The
+ * R_SS_WC bits in this register can trigger an interrupt to the application
+ * through the Host Port Interrupt bit of the Core Interrupt register
+ * (GINTSTS.PrtInt). On a Port Interrupt, the application must read this
+ * register and clear the bit that caused the interrupt. For the R_SS_WC
+ * bits, the application must write a 1 to the bit to clear the interrupt.
  */
 union cvmx_usbcx_hprt {
 	uint32_t u32;
@@ -3392,7 +3469,8 @@ typedef union cvmx_usbcx_hprt cvmx_usbcx_hprt_t;
  *
  * Host Periodic Transmit FIFO Size Register (HPTXFSIZ)
  *
- * This register holds the size and the memory start address of the Periodic TxFIFO, as shown in Figures 310 and 311.
+ * This register holds the size and the memory start address of the
+ * Periodic TxFIFO, as shown in Figures 310 and 311.
  */
 union cvmx_usbcx_hptxfsiz {
 	uint32_t u32;
@@ -3423,8 +3501,8 @@ typedef union cvmx_usbcx_hptxfsiz cvmx_usbcx_hptxfsiz_t;
  *
  * Host Periodic Transmit FIFO/Queue Status Register (HPTXSTS)
  *
- * This read-only register contains the free space information for the Periodic TxFIFO and
- * the Periodic Transmit Request Queue
+ * This read-only register contains the free space information for the Periodic
+ * TxFIFO and the Periodic Transmit Request Queue
  */
 union cvmx_usbcx_hptxsts {
 	uint32_t u32;
@@ -3447,17 +3525,18 @@ union cvmx_usbcx_hptxsts {
 	 *	channel/endpoint)
 	 * @ptxqspcavail: Periodic Transmit Request Queue Space Available
 	 *	(PTxQSpcAvail)
-	 *	Indicates the number of free locations available to be written in
-	 *	the Periodic Transmit Request Queue. This queue holds both
+	 *	Indicates the number of free locations available to be written
+	 *	in the Periodic Transmit Request Queue. This queue holds both
 	 *	IN and OUT requests.
 	 *	* 8'h0: Periodic Transmit Request Queue is full
 	 *	* 8'h1: 1 location available
 	 *	* 8'h2: 2 locations available
 	 *	* n: n locations available (0..8)
 	 *	* Others: Reserved
-	 * @ptxfspcavail: Periodic Transmit Data FIFO Space Available (PTxFSpcAvail)
-	 *	Indicates the number of free locations available to be written to
-	 *	in the Periodic TxFIFO.
+	 * @ptxfspcavail: Periodic Transmit Data FIFO Space Available
+	 *		  (PTxFSpcAvail)
+	 *	Indicates the number of free locations available to be written
+	 *	to in the Periodic TxFIFO.
 	 *	Values are in terms of 32-bit words
 	 *	* 16'h0: Periodic TxFIFO is full
 	 *	* 16'h1: 1 word available
@@ -3486,7 +3565,8 @@ typedef union cvmx_usbcx_hptxsts cvmx_usbcx_hptxsts_t;
  *
  * NPTX Data Fifo (NPTXDFIFO)
  *
- * A slave mode application uses this register to access the Tx FIFO for channel n.
+ * A slave mode application uses this register to access the Tx FIFO
+ * for channel n.
  */
 union cvmx_usbcx_nptxdfifox {
 	uint32_t u32;
@@ -3512,7 +3592,8 @@ typedef union cvmx_usbcx_nptxdfifox cvmx_usbcx_nptxdfifox_t;
  *
  * Power and Clock Gating Control Register (PCGCCTL)
  *
- * The application can use this register to control the core's power-down and clock gating features.
+ * The application can use this register to control the core's power-down
+ * and clock gating features.
  */
 union cvmx_usbcx_pcgcctl {
 	uint32_t u32;
@@ -3520,8 +3601,8 @@ union cvmx_usbcx_pcgcctl {
 	 * struct cvmx_usbcx_pcgcctl_s
 	 * @physuspended: PHY Suspended. (PhySuspended)
 	 *	Indicates that the PHY has been suspended. After the
-	 *	application sets the Stop Pclk bit (bit 0), this bit is updated once
-	 *	the PHY is suspended.
+	 *	application sets the Stop Pclk bit (bit 0), this bit is updated
+	 *	once the PHY is suspended.
 	 *	Since the UTMI+ PHY suspend is controlled through a port, the
 	 *	UTMI+ PHY is suspended immediately after Stop Pclk is set.
 	 *	However, the ULPI PHY takes a few clocks to suspend,
@@ -3534,8 +3615,8 @@ union cvmx_usbcx_pcgcctl {
 	 *	PHY clock is up.
 	 * @pwrclmp: Power Clamp (PwrClmp)
 	 *	This bit is only valid in Partial Power-Down mode. The
-	 *	application sets this bit before the power is turned off to clamp
-	 *	the signals between the power-on modules and the power-off
+	 *	application sets this bit before the power is turned off to
+	 *	clamp the signals between the power-on modules and the power-off
 	 *	modules. The application clears the bit to disable the clamping
 	 *	before the power is turned on.
 	 * @gatehclk: Gate Hclk (GateHclk)
-- 
1.7.10.4
