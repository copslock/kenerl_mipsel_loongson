Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jun 2013 23:32:25 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:58553 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835008Ab3FDVbx0wWXh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jun 2013 23:31:53 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 9B5605A7052;
        Wed,  5 Jun 2013 00:31:49 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id z1hFsR-VRQf8; Wed,  5 Jun 2013 00:31:49 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp4.welho.com (Postfix) with ESMTP id D84F65BC011;
        Wed,  5 Jun 2013 00:31:45 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/6] staging: octeon-usb: run cvmx-usbcx-defs.h through Lindent
Date:   Wed,  5 Jun 2013 00:31:30 +0300
Message-Id: <1370381495-3358-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1370381495-3358-1-git-send-email-aaro.koskinen@iki.fi>
References: <1370381495-3358-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36677
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

Run cvmx-usbcx-defs.h through Lindent to fix the most obvious coding
style violations.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/staging/octeon-usb/cvmx-usbcx-defs.h | 1815 ++++++++++++--------------
 1 file changed, 855 insertions(+), 960 deletions(-)

diff --git a/drivers/staging/octeon-usb/cvmx-usbcx-defs.h b/drivers/staging/octeon-usb/cvmx-usbcx-defs.h
index e3ae545..2ec0deb 100644
--- a/drivers/staging/octeon-usb/cvmx-usbcx-defs.h
+++ b/drivers/staging/octeon-usb/cvmx-usbcx-defs.h
@@ -37,7 +37,6 @@
  * PERFORMANCE OF THE SOFTWARE LIES WITH YOU.
  ***********************license end**************************************/
 
-
 /**
  * cvmx-usbcx-defs.h
  *
@@ -118,25 +117,23 @@
  * bits are used. Bits in this register are set and cleared when the application sets and clears
  * bits in the corresponding Device Endpoint-n Interrupt register (DIEPINTn/DOEPINTn).
  */
-union cvmx_usbcx_daint
-{
+union cvmx_usbcx_daint {
 	uint32_t u32;
-	struct cvmx_usbcx_daint_s
-	{
-	uint32_t outepint                     : 16; /**< OUT Endpoint Interrupt Bits (OutEPInt)
+	struct cvmx_usbcx_daint_s {
+		uint32_t outepint:16;		    /**< OUT Endpoint Interrupt Bits (OutEPInt)
                                                          One bit per OUT endpoint:
                                                          Bit 16 for OUT endpoint 0, bit 31 for OUT endpoint 15 */
-	uint32_t inepint                      : 16; /**< IN Endpoint Interrupt Bits (InEpInt)
+		uint32_t inepint:16;		    /**< IN Endpoint Interrupt Bits (InEpInt)
                                                          One bit per IN Endpoint:
                                                          Bit 0 for IN endpoint 0, bit 15 for endpoint 15 */
 	} s;
-	struct cvmx_usbcx_daint_s             cn30xx;
-	struct cvmx_usbcx_daint_s             cn31xx;
-	struct cvmx_usbcx_daint_s             cn50xx;
-	struct cvmx_usbcx_daint_s             cn52xx;
-	struct cvmx_usbcx_daint_s             cn52xxp1;
-	struct cvmx_usbcx_daint_s             cn56xx;
-	struct cvmx_usbcx_daint_s             cn56xxp1;
+	struct cvmx_usbcx_daint_s cn30xx;
+	struct cvmx_usbcx_daint_s cn31xx;
+	struct cvmx_usbcx_daint_s cn50xx;
+	struct cvmx_usbcx_daint_s cn52xx;
+	struct cvmx_usbcx_daint_s cn52xxp1;
+	struct cvmx_usbcx_daint_s cn56xx;
+	struct cvmx_usbcx_daint_s cn56xxp1;
 };
 typedef union cvmx_usbcx_daint cvmx_usbcx_daint_t;
 
@@ -150,25 +147,23 @@ typedef union cvmx_usbcx_daint cvmx_usbcx_daint_t;
  * All Endpoints Interrupt (DAINT) register bit corresponding to that interrupt will still be set.
  * Mask Interrupt: 1'b0 Unmask Interrupt: 1'b1
  */
-union cvmx_usbcx_daintmsk
-{
+union cvmx_usbcx_daintmsk {
 	uint32_t u32;
-	struct cvmx_usbcx_daintmsk_s
-	{
-	uint32_t outepmsk                     : 16; /**< OUT EP Interrupt Mask Bits (OutEpMsk)
+	struct cvmx_usbcx_daintmsk_s {
+		uint32_t outepmsk:16;		    /**< OUT EP Interrupt Mask Bits (OutEpMsk)
                                                          One per OUT Endpoint:
                                                          Bit 16 for OUT EP 0, bit 31 for OUT EP 15 */
-	uint32_t inepmsk                      : 16; /**< IN EP Interrupt Mask Bits (InEpMsk)
+		uint32_t inepmsk:16;		    /**< IN EP Interrupt Mask Bits (InEpMsk)
                                                          One bit per IN Endpoint:
                                                          Bit 0 for IN EP 0, bit 15 for IN EP 15 */
 	} s;
-	struct cvmx_usbcx_daintmsk_s          cn30xx;
-	struct cvmx_usbcx_daintmsk_s          cn31xx;
-	struct cvmx_usbcx_daintmsk_s          cn50xx;
-	struct cvmx_usbcx_daintmsk_s          cn52xx;
-	struct cvmx_usbcx_daintmsk_s          cn52xxp1;
-	struct cvmx_usbcx_daintmsk_s          cn56xx;
-	struct cvmx_usbcx_daintmsk_s          cn56xxp1;
+	struct cvmx_usbcx_daintmsk_s cn30xx;
+	struct cvmx_usbcx_daintmsk_s cn31xx;
+	struct cvmx_usbcx_daintmsk_s cn50xx;
+	struct cvmx_usbcx_daintmsk_s cn52xx;
+	struct cvmx_usbcx_daintmsk_s cn52xxp1;
+	struct cvmx_usbcx_daintmsk_s cn56xx;
+	struct cvmx_usbcx_daintmsk_s cn56xxp1;
 };
 typedef union cvmx_usbcx_daintmsk cvmx_usbcx_daintmsk_t;
 
@@ -180,21 +175,19 @@ typedef union cvmx_usbcx_daintmsk cvmx_usbcx_daintmsk_t;
  * This register configures the core in Device mode after power-on or after certain control
  * commands or enumeration. Do not make changes to this register after initial programming.
  */
-union cvmx_usbcx_dcfg
-{
+union cvmx_usbcx_dcfg {
 	uint32_t u32;
-	struct cvmx_usbcx_dcfg_s
-	{
-	uint32_t reserved_23_31               : 9;
-	uint32_t epmiscnt                     : 5;  /**< IN Endpoint Mismatch Count (EPMisCnt)
+	struct cvmx_usbcx_dcfg_s {
+		uint32_t reserved_23_31:9;
+		uint32_t epmiscnt:5;		    /**< IN Endpoint Mismatch Count (EPMisCnt)
                                                          The application programs this filed with a count that determines
                                                          when the core generates an Endpoint Mismatch interrupt
                                                          (GINTSTS.EPMis). The core loads this value into an internal
                                                          counter and decrements it. The counter is reloaded whenever
                                                          there is a match or when the counter expires. The width of this
                                                          counter depends on the depth of the Token Queue. */
-	uint32_t reserved_13_17               : 5;
-	uint32_t perfrint                     : 2;  /**< Periodic Frame Interval (PerFrInt)
+		uint32_t reserved_13_17:5;
+		uint32_t perfrint:2;		    /**< Periodic Frame Interval (PerFrInt)
                                                          Indicates the time within a (micro)frame at which the application
                                                          must be notified using the End Of Periodic Frame Interrupt. This
                                                          can be used to determine if all the isochronous traffic for that
@@ -203,11 +196,11 @@ union cvmx_usbcx_dcfg
                                                          * 2'b01: 85%
                                                          * 2'b10: 90%
                                                          * 2'b11: 95% */
-	uint32_t devaddr                      : 7;  /**< Device Address (DevAddr)
+		uint32_t devaddr:7;		    /**< Device Address (DevAddr)
                                                          The application must program this field after every SetAddress
                                                          control command. */
-	uint32_t reserved_3_3                 : 1;
-	uint32_t nzstsouthshk                 : 1;  /**< Non-Zero-Length Status OUT Handshake (NZStsOUTHShk)
+		uint32_t reserved_3_3:1;
+		uint32_t nzstsouthshk:1;	    /**< Non-Zero-Length Status OUT Handshake (NZStsOUTHShk)
                                                          The application can use this field to select the handshake the
                                                          core sends on receiving a nonzero-length data packet during
                                                          the OUT transaction of a control transfer's Status stage.
@@ -218,7 +211,7 @@ union cvmx_usbcx_dcfg
                                                                  length or nonzero-length) and send a handshake based on
                                                                  the NAK and STALL bits for the endpoint in the Device
                                                                  Endpoint Control register. */
-	uint32_t devspd                       : 2;  /**< Device Speed (DevSpd)
+		uint32_t devspd:2;		    /**< Device Speed (DevSpd)
                                                          Indicates the speed at which the application requires the core to
                                                          enumerate, or the maximum speed the application can support.
                                                          However, the actual bus speed is determined only after the
@@ -231,13 +224,13 @@ union cvmx_usbcx_dcfg
                                                                   you select 6 MHz LS mode, you must do a soft reset.
                                                          * 2'b11: Full speed (USB 1.1 transceiver clock is 48 MHz) */
 	} s;
-	struct cvmx_usbcx_dcfg_s              cn30xx;
-	struct cvmx_usbcx_dcfg_s              cn31xx;
-	struct cvmx_usbcx_dcfg_s              cn50xx;
-	struct cvmx_usbcx_dcfg_s              cn52xx;
-	struct cvmx_usbcx_dcfg_s              cn52xxp1;
-	struct cvmx_usbcx_dcfg_s              cn56xx;
-	struct cvmx_usbcx_dcfg_s              cn56xxp1;
+	struct cvmx_usbcx_dcfg_s cn30xx;
+	struct cvmx_usbcx_dcfg_s cn31xx;
+	struct cvmx_usbcx_dcfg_s cn50xx;
+	struct cvmx_usbcx_dcfg_s cn52xx;
+	struct cvmx_usbcx_dcfg_s cn52xxp1;
+	struct cvmx_usbcx_dcfg_s cn56xx;
+	struct cvmx_usbcx_dcfg_s cn56xxp1;
 };
 typedef union cvmx_usbcx_dcfg cvmx_usbcx_dcfg_t;
 
@@ -247,29 +240,27 @@ typedef union cvmx_usbcx_dcfg cvmx_usbcx_dcfg_t;
  * Device Control Register (DCTL)
  *
  */
-union cvmx_usbcx_dctl
-{
+union cvmx_usbcx_dctl {
 	uint32_t u32;
-	struct cvmx_usbcx_dctl_s
-	{
-	uint32_t reserved_12_31               : 20;
-	uint32_t pwronprgdone                 : 1;  /**< Power-On Programming Done (PWROnPrgDone)
+	struct cvmx_usbcx_dctl_s {
+		uint32_t reserved_12_31:20;
+		uint32_t pwronprgdone:1;	    /**< Power-On Programming Done (PWROnPrgDone)
                                                          The application uses this bit to indicate that register
                                                          programming is completed after a wake-up from Power Down
                                                          mode. For more information, see "Device Mode Suspend and
                                                          Resume With Partial Power-Down" on page 357. */
-	uint32_t cgoutnak                     : 1;  /**< Clear Global OUT NAK (CGOUTNak)
+		uint32_t cgoutnak:1;		    /**< Clear Global OUT NAK (CGOUTNak)
                                                          A write to this field clears the Global OUT NAK. */
-	uint32_t sgoutnak                     : 1;  /**< Set Global OUT NAK (SGOUTNak)
+		uint32_t sgoutnak:1;		    /**< Set Global OUT NAK (SGOUTNak)
                                                          A write to this field sets the Global OUT NAK.
                                                          The application uses this bit to send a NAK handshake on all
                                                          OUT endpoints.
                                                          The application should set the this bit only after making sure
                                                          that the Global OUT NAK Effective bit in the Core Interrupt
                                                          Register (GINTSTS.GOUTNakEff) is cleared. */
-	uint32_t cgnpinnak                    : 1;  /**< Clear Global Non-Periodic IN NAK (CGNPInNak)
+		uint32_t cgnpinnak:1;		    /**< Clear Global Non-Periodic IN NAK (CGNPInNak)
                                                          A write to this field clears the Global Non-Periodic IN NAK. */
-	uint32_t sgnpinnak                    : 1;  /**< Set Global Non-Periodic IN NAK (SGNPInNak)
+		uint32_t sgnpinnak:1;		    /**< Set Global Non-Periodic IN NAK (SGNPInNak)
                                                          A write to this field sets the Global Non-Periodic IN NAK.The
                                                          application uses this bit to send a NAK handshake on all non-
                                                          periodic IN endpoints. The core can also set this bit when a
@@ -277,7 +268,7 @@ union cvmx_usbcx_dctl
                                                          The application should set this bit only after making sure that
                                                          the Global IN NAK Effective bit in the Core Interrupt Register
                                                          (GINTSTS.GINNakEff) is cleared. */
-	uint32_t tstctl                       : 3;  /**< Test Control (TstCtl)
+		uint32_t tstctl:3;		    /**< Test Control (TstCtl)
                                                          * 3'b000: Test mode disabled
                                                          * 3'b001: Test_J mode
                                                          * 3'b010: Test_K mode
@@ -285,20 +276,20 @@ union cvmx_usbcx_dctl
                                                          * 3'b100: Test_Packet mode
                                                          * 3'b101: Test_Force_Enable
                                                          * Others: Reserved */
-	uint32_t goutnaksts                   : 1;  /**< Global OUT NAK Status (GOUTNakSts)
+		uint32_t goutnaksts:1;		    /**< Global OUT NAK Status (GOUTNakSts)
                                                          * 1'b0: A handshake is sent based on the FIFO Status and the
                                                                  NAK and STALL bit settings.
                                                          * 1'b1: No data is written to the RxFIFO, irrespective of space
                                                                  availability. Sends a NAK handshake on all packets, except
                                                                  on SETUP transactions. All isochronous OUT packets are
                                                                  dropped. */
-	uint32_t gnpinnaksts                  : 1;  /**< Global Non-Periodic IN NAK Status (GNPINNakSts)
+		uint32_t gnpinnaksts:1;		    /**< Global Non-Periodic IN NAK Status (GNPINNakSts)
                                                          * 1'b0: A handshake is sent out based on the data availability
                                                                  in the transmit FIFO.
                                                          * 1'b1: A NAK handshake is sent out on all non-periodic IN
                                                                  endpoints, irrespective of the data availability in the transmit
                                                                  FIFO. */
-	uint32_t sftdiscon                    : 1;  /**< Soft Disconnect (SftDiscon)
+		uint32_t sftdiscon:1;		    /**< Soft Disconnect (SftDiscon)
                                                          The application uses this bit to signal the O2P USB core to do a
                                                          soft disconnect. As long as this bit is set, the host will not see
                                                          that the device is connected, and the device will not receive
@@ -314,19 +305,19 @@ union cvmx_usbcx_dctl
                                                          * 1'b1: The core drives the phy_opmode_o signal on the
                                                          UTMI+ to 2'b01, which generates a device disconnect event
                                                          to the USB host. */
-	uint32_t rmtwkupsig                   : 1;  /**< Remote Wakeup Signaling (RmtWkUpSig)
+		uint32_t rmtwkupsig:1;		    /**< Remote Wakeup Signaling (RmtWkUpSig)
                                                          When the application sets this bit, the core initiates remote
                                                          signaling to wake up the USB host.The application must set this
                                                          bit to get the core out of Suspended state and must clear this bit
                                                          after the core comes out of Suspended state. */
 	} s;
-	struct cvmx_usbcx_dctl_s              cn30xx;
-	struct cvmx_usbcx_dctl_s              cn31xx;
-	struct cvmx_usbcx_dctl_s              cn50xx;
-	struct cvmx_usbcx_dctl_s              cn52xx;
-	struct cvmx_usbcx_dctl_s              cn52xxp1;
-	struct cvmx_usbcx_dctl_s              cn56xx;
-	struct cvmx_usbcx_dctl_s              cn56xxp1;
+	struct cvmx_usbcx_dctl_s cn30xx;
+	struct cvmx_usbcx_dctl_s cn31xx;
+	struct cvmx_usbcx_dctl_s cn50xx;
+	struct cvmx_usbcx_dctl_s cn52xx;
+	struct cvmx_usbcx_dctl_s cn52xxp1;
+	struct cvmx_usbcx_dctl_s cn56xx;
+	struct cvmx_usbcx_dctl_s cn56xxp1;
 };
 typedef union cvmx_usbcx_dctl cvmx_usbcx_dctl_t;
 
@@ -337,18 +328,16 @@ typedef union cvmx_usbcx_dctl cvmx_usbcx_dctl_t;
  *
  * The application uses the register to control the behaviour of each logical endpoint other than endpoint 0.
  */
-union cvmx_usbcx_diepctlx
-{
+union cvmx_usbcx_diepctlx {
 	uint32_t u32;
-	struct cvmx_usbcx_diepctlx_s
-	{
-	uint32_t epena                        : 1;  /**< Endpoint Enable (EPEna)
+	struct cvmx_usbcx_diepctlx_s {
+		uint32_t epena:1;		    /**< Endpoint Enable (EPEna)
                                                          Indicates that data is ready to be transmitted on the endpoint.
                                                          The core clears this bit before setting any of the following
                                                          interrupts on this endpoint:
                                                          * Endpoint Disabled
                                                          * Transfer Completed */
-	uint32_t epdis                        : 1;  /**< Endpoint Disable (EPDis)
+		uint32_t epdis:1;		    /**< Endpoint Disable (EPDis)
                                                          The application sets this bit to stop transmitting data on an
                                                          endpoint, even before the transfer for that endpoint is complete.
                                                          The application must wait for the Endpoint Disabled interrupt
@@ -356,7 +345,7 @@ union cvmx_usbcx_diepctlx
                                                          before setting the Endpoint Disabled Interrupt. The application
                                                          should set this bit only if Endpoint Enable is already set for this
                                                          endpoint. */
-	uint32_t setd1pid                     : 1;  /**< For Interrupt/BULK enpoints:
+		uint32_t setd1pid:1;		    /**< For Interrupt/BULK enpoints:
                                                           Set DATA1 PID (SetD1PID)
                                                           Writing to this field sets the Endpoint Data Pid (DPID) field in
                                                           this register to DATA1.
@@ -364,28 +353,28 @@ union cvmx_usbcx_diepctlx
                                                           Set Odd (micro)frame (SetOddFr)
                                                           Writing to this field sets the Even/Odd (micro)frame (EO_FrNum)
                                                           field to odd (micro)frame. */
-	uint32_t setd0pid                     : 1;  /**< For Interrupt/BULK enpoints:
+		uint32_t setd0pid:1;		    /**< For Interrupt/BULK enpoints:
                                                           Writing to this field sets the Endpoint Data Pid (DPID) field in
                                                           this register to DATA0.
                                                          For Isochronous endpoints:
                                                           Set Odd (micro)frame (SetEvenFr)
                                                           Writing to this field sets the Even/Odd (micro)frame (EO_FrNum)
                                                           field to even (micro)frame. */
-	uint32_t snak                         : 1;  /**< Set NAK (SNAK)
+		uint32_t snak:1;		    /**< Set NAK (SNAK)
                                                          A write to this bit sets the NAK bit for the endpoint.
                                                          Using this bit, the application can control the transmission of
                                                          NAK handshakes on an endpoint. The core can also set this bit
                                                          for an endpoint after a SETUP packet is received on the
                                                          endpoint. */
-	uint32_t cnak                         : 1;  /**< Clear NAK (CNAK)
+		uint32_t cnak:1;		    /**< Clear NAK (CNAK)
                                                          A write to this bit clears the NAK bit for the endpoint. */
-	uint32_t txfnum                       : 4;  /**< TxFIFO Number (TxFNum)
+		uint32_t txfnum:4;		    /**< TxFIFO Number (TxFNum)
                                                          Non-periodic endpoints must set this bit to zero.  Periodic
                                                          endpoints must map this to the corresponding Periodic TxFIFO
                                                          number.
                                                          * 4'h0: Non-Periodic TxFIFO
                                                          * Others: Specified Periodic TxFIFO number */
-	uint32_t stall                        : 1;  /**< STALL Handshake (Stall)
+		uint32_t stall:1;		    /**< STALL Handshake (Stall)
                                                          For non-control, non-isochronous endpoints:
                                                           The application sets this bit to stall all tokens from the USB host
                                                           to this endpoint.  If a NAK bit, Global Non-Periodic IN NAK, or
@@ -397,14 +386,14 @@ union cvmx_usbcx_diepctlx
                                                           Non-Periodic IN NAK, or Global OUT NAK is set along with this
                                                           bit, the STALL bit takes priority.  Irrespective of this bit's setting,
                                                           the core always responds to SETUP data packets with an ACK handshake. */
-	uint32_t reserved_20_20               : 1;
-	uint32_t eptype                       : 2;  /**< Endpoint Type (EPType)
+		uint32_t reserved_20_20:1;
+		uint32_t eptype:2;		    /**< Endpoint Type (EPType)
                                                          This is the transfer type supported by this logical endpoint.
                                                          * 2'b00: Control
                                                          * 2'b01: Isochronous
                                                          * 2'b10: Bulk
                                                          * 2'b11: Interrupt */
-	uint32_t naksts                       : 1;  /**< NAK Status (NAKSts)
+		uint32_t naksts:1;		    /**< NAK Status (NAKSts)
                                                          Indicates the following:
                                                          * 1'b0: The core is transmitting non-NAK handshakes based
                                                                  on the FIFO status
@@ -418,7 +407,7 @@ union cvmx_usbcx_diepctlx
                                                            length data packet, even if data is available in the TxFIFO.
                                                          Irrespective of this bit's setting, the core always responds to
                                                          SETUP data packets with an ACK handshake. */
-	uint32_t dpid                         : 1;  /**< For interrupt/bulk IN and OUT endpoints:
+		uint32_t dpid:1;		    /**< For interrupt/bulk IN and OUT endpoints:
                                                           Endpoint Data PID (DPID)
                                                           Contains the PID of the packet to be received or transmitted on
                                                           this endpoint.  The application should program the PID of the first
@@ -437,32 +426,32 @@ union cvmx_usbcx_diepctlx
                                                           using the SetEvnFr and SetOddFr fields in this register.
                                                           * 1'b0: Even (micro)frame
                                                           * 1'b1: Odd (micro)frame */
-	uint32_t usbactep                     : 1;  /**< USB Active Endpoint (USBActEP)
+		uint32_t usbactep:1;		    /**< USB Active Endpoint (USBActEP)
                                                          Indicates whether this endpoint is active in the current
                                                          configuration and interface.  The core clears this bit for all
                                                          endpoints (other than EP 0) after detecting a USB reset.  After
                                                          receiving the SetConfiguration and SetInterface commands, the
                                                          application must program endpoint registers accordingly and set
                                                          this bit. */
-	uint32_t nextep                       : 4;  /**< Next Endpoint (NextEp)
+		uint32_t nextep:4;		    /**< Next Endpoint (NextEp)
                                                          Applies to non-periodic IN endpoints only.
                                                          Indicates the endpoint number to be fetched after the data for
                                                          the current endpoint is fetched. The core can access this field,
                                                          even when the Endpoint Enable (EPEna) bit is not set. This
                                                          field is not valid in Slave mode. */
-	uint32_t mps                          : 11; /**< Maximum Packet Size (MPS)
+		uint32_t mps:11;		    /**< Maximum Packet Size (MPS)
                                                          Applies to IN and OUT endpoints.
                                                          The application must program this field with the maximum
                                                          packet size for the current logical endpoint.  This value is in
                                                          bytes. */
 	} s;
-	struct cvmx_usbcx_diepctlx_s          cn30xx;
-	struct cvmx_usbcx_diepctlx_s          cn31xx;
-	struct cvmx_usbcx_diepctlx_s          cn50xx;
-	struct cvmx_usbcx_diepctlx_s          cn52xx;
-	struct cvmx_usbcx_diepctlx_s          cn52xxp1;
-	struct cvmx_usbcx_diepctlx_s          cn56xx;
-	struct cvmx_usbcx_diepctlx_s          cn56xxp1;
+	struct cvmx_usbcx_diepctlx_s cn30xx;
+	struct cvmx_usbcx_diepctlx_s cn31xx;
+	struct cvmx_usbcx_diepctlx_s cn50xx;
+	struct cvmx_usbcx_diepctlx_s cn52xx;
+	struct cvmx_usbcx_diepctlx_s cn52xxp1;
+	struct cvmx_usbcx_diepctlx_s cn56xx;
+	struct cvmx_usbcx_diepctlx_s cn56xxp1;
 };
 typedef union cvmx_usbcx_diepctlx cvmx_usbcx_diepctlx_t;
 
@@ -481,13 +470,11 @@ typedef union cvmx_usbcx_diepctlx cvmx_usbcx_diepctlx_t;
  * register. The application must clear the appropriate bit in this register
  * to clear the corresponding bits in the DAINT and GINTSTS registers.
  */
-union cvmx_usbcx_diepintx
-{
+union cvmx_usbcx_diepintx {
 	uint32_t u32;
-	struct cvmx_usbcx_diepintx_s
-	{
-	uint32_t reserved_7_31                : 25;
-	uint32_t inepnakeff                   : 1;  /**< IN Endpoint NAK Effective (INEPNakEff)
+	struct cvmx_usbcx_diepintx_s {
+		uint32_t reserved_7_31:25;
+		uint32_t inepnakeff:1;		    /**< IN Endpoint NAK Effective (INEPNakEff)
                                                          Applies to periodic IN endpoints only.
                                                          Indicates that the IN endpoint NAK bit set by the application has
                                                          taken effect in the core. This bit can be cleared when the
@@ -497,40 +484,40 @@ union cvmx_usbcx_diepintx
                                                          set (either by the application or by the core).
                                                          This interrupt does not necessarily mean that a NAK handshake
                                                          is sent on the USB. A STALL bit takes priority over a NAK bit. */
-	uint32_t intknepmis                   : 1;  /**< IN Token Received with EP Mismatch (INTknEPMis)
+		uint32_t intknepmis:1;		    /**< IN Token Received with EP Mismatch (INTknEPMis)
                                                          Applies to non-periodic IN endpoints only.
                                                          Indicates that the data in the top of the non-periodic TxFIFO
                                                          belongs to an endpoint other than the one for which the IN
                                                          token was received. This interrupt is asserted on the endpoint
                                                          for which the IN token was received. */
-	uint32_t intkntxfemp                  : 1;  /**< IN Token Received When TxFIFO is Empty (INTknTXFEmp)
+		uint32_t intkntxfemp:1;		    /**< IN Token Received When TxFIFO is Empty (INTknTXFEmp)
                                                          Applies only to non-periodic IN endpoints.
                                                          Indicates that an IN token was received when the associated
                                                          TxFIFO (periodic/non-periodic) was empty. This interrupt is
                                                          asserted on the endpoint for which the IN token was received. */
-	uint32_t timeout                      : 1;  /**< Timeout Condition (TimeOUT)
+		uint32_t timeout:1;		    /**< Timeout Condition (TimeOUT)
                                                          Applies to non-isochronous IN endpoints only.
                                                          Indicates that the core has detected a timeout condition on the
                                                          USB for the last IN token on this endpoint. */
-	uint32_t ahberr                       : 1;  /**< AHB Error (AHBErr)
+		uint32_t ahberr:1;		    /**< AHB Error (AHBErr)
                                                          This is generated only in Internal DMA mode when there is an
                                                          AHB error during an AHB read/write. The application can read
                                                          the corresponding endpoint DMA address register to get the
                                                          error address. */
-	uint32_t epdisbld                     : 1;  /**< Endpoint Disabled Interrupt (EPDisbld)
+		uint32_t epdisbld:1;		    /**< Endpoint Disabled Interrupt (EPDisbld)
                                                          This bit indicates that the endpoint is disabled per the
                                                          application's request. */
-	uint32_t xfercompl                    : 1;  /**< Transfer Completed Interrupt (XferCompl)
+		uint32_t xfercompl:1;		    /**< Transfer Completed Interrupt (XferCompl)
                                                          Indicates that the programmed transfer is complete on the AHB
                                                          as well as on the USB, for this endpoint. */
 	} s;
-	struct cvmx_usbcx_diepintx_s          cn30xx;
-	struct cvmx_usbcx_diepintx_s          cn31xx;
-	struct cvmx_usbcx_diepintx_s          cn50xx;
-	struct cvmx_usbcx_diepintx_s          cn52xx;
-	struct cvmx_usbcx_diepintx_s          cn52xxp1;
-	struct cvmx_usbcx_diepintx_s          cn56xx;
-	struct cvmx_usbcx_diepintx_s          cn56xxp1;
+	struct cvmx_usbcx_diepintx_s cn30xx;
+	struct cvmx_usbcx_diepintx_s cn31xx;
+	struct cvmx_usbcx_diepintx_s cn50xx;
+	struct cvmx_usbcx_diepintx_s cn52xx;
+	struct cvmx_usbcx_diepintx_s cn52xxp1;
+	struct cvmx_usbcx_diepintx_s cn56xx;
+	struct cvmx_usbcx_diepintx_s cn56xxp1;
 };
 typedef union cvmx_usbcx_diepintx cvmx_usbcx_diepintx_t;
 
@@ -545,29 +532,27 @@ typedef union cvmx_usbcx_diepintx cvmx_usbcx_diepintx_t;
  * bit in this register. Status bits are masked by default.
  * Mask interrupt: 1'b0 Unmask interrupt: 1'b1
  */
-union cvmx_usbcx_diepmsk
-{
+union cvmx_usbcx_diepmsk {
 	uint32_t u32;
-	struct cvmx_usbcx_diepmsk_s
-	{
-	uint32_t reserved_7_31                : 25;
-	uint32_t inepnakeffmsk                : 1;  /**< IN Endpoint NAK Effective Mask (INEPNakEffMsk) */
-	uint32_t intknepmismsk                : 1;  /**< IN Token received with EP Mismatch Mask (INTknEPMisMsk) */
-	uint32_t intkntxfempmsk               : 1;  /**< IN Token Received When TxFIFO Empty Mask
+	struct cvmx_usbcx_diepmsk_s {
+		uint32_t reserved_7_31:25;
+		uint32_t inepnakeffmsk:1;	    /**< IN Endpoint NAK Effective Mask (INEPNakEffMsk) */
+		uint32_t intknepmismsk:1;	    /**< IN Token received with EP Mismatch Mask (INTknEPMisMsk) */
+		uint32_t intkntxfempmsk:1;	    /**< IN Token Received When TxFIFO Empty Mask
                                                          (INTknTXFEmpMsk) */
-	uint32_t timeoutmsk                   : 1;  /**< Timeout Condition Mask (TimeOUTMsk)
+		uint32_t timeoutmsk:1;		    /**< Timeout Condition Mask (TimeOUTMsk)
                                                          (Non-isochronous endpoints) */
-	uint32_t ahberrmsk                    : 1;  /**< AHB Error Mask (AHBErrMsk) */
-	uint32_t epdisbldmsk                  : 1;  /**< Endpoint Disabled Interrupt Mask (EPDisbldMsk) */
-	uint32_t xfercomplmsk                 : 1;  /**< Transfer Completed Interrupt Mask (XferComplMsk) */
+		uint32_t ahberrmsk:1;		    /**< AHB Error Mask (AHBErrMsk) */
+		uint32_t epdisbldmsk:1;		    /**< Endpoint Disabled Interrupt Mask (EPDisbldMsk) */
+		uint32_t xfercomplmsk:1;	    /**< Transfer Completed Interrupt Mask (XferComplMsk) */
 	} s;
-	struct cvmx_usbcx_diepmsk_s           cn30xx;
-	struct cvmx_usbcx_diepmsk_s           cn31xx;
-	struct cvmx_usbcx_diepmsk_s           cn50xx;
-	struct cvmx_usbcx_diepmsk_s           cn52xx;
-	struct cvmx_usbcx_diepmsk_s           cn52xxp1;
-	struct cvmx_usbcx_diepmsk_s           cn56xx;
-	struct cvmx_usbcx_diepmsk_s           cn56xxp1;
+	struct cvmx_usbcx_diepmsk_s cn30xx;
+	struct cvmx_usbcx_diepmsk_s cn31xx;
+	struct cvmx_usbcx_diepmsk_s cn50xx;
+	struct cvmx_usbcx_diepmsk_s cn52xx;
+	struct cvmx_usbcx_diepmsk_s cn52xxp1;
+	struct cvmx_usbcx_diepmsk_s cn56xx;
+	struct cvmx_usbcx_diepmsk_s cn56xxp1;
 };
 typedef union cvmx_usbcx_diepmsk cvmx_usbcx_diepmsk_t;
 
@@ -581,13 +566,11 @@ typedef union cvmx_usbcx_diepmsk cvmx_usbcx_diepmsk_t;
  * the core modifies this register. The application can only read this register once the core has cleared the Endpoint Enable bit.
  * This register is used only for endpoints other than Endpoint 0.
  */
-union cvmx_usbcx_dieptsizx
-{
+union cvmx_usbcx_dieptsizx {
 	uint32_t u32;
-	struct cvmx_usbcx_dieptsizx_s
-	{
-	uint32_t reserved_31_31               : 1;
-	uint32_t mc                           : 2;  /**< Multi Count (MC)
+	struct cvmx_usbcx_dieptsizx_s {
+		uint32_t reserved_31_31:1;
+		uint32_t mc:2;			    /**< Multi Count (MC)
                                                          Applies to IN endpoints only.
                                                          For periodic IN endpoints, this field indicates the number of
                                                          packets that must be transmitted per microframe on the USB.
@@ -601,12 +584,12 @@ union cvmx_usbcx_dieptsizx
                                                          fetch for an IN endpoint before it switches to the endpoint
                                                          pointed to by the Next Endpoint field of the Device Endpoint-n
                                                          Control register (DIEPCTLn.NextEp) */
-	uint32_t pktcnt                       : 10; /**< Packet Count (PktCnt)
+		uint32_t pktcnt:10;		    /**< Packet Count (PktCnt)
                                                          Indicates the total number of USB packets that constitute the
                                                          Transfer Size amount of data for this endpoint.
                                                          IN Endpoints: This field is decremented every time a packet
                                                          (maximum size or short packet) is read from the TxFIFO. */
-	uint32_t xfersize                     : 19; /**< Transfer Size (XferSize)
+		uint32_t xfersize:19;		    /**< Transfer Size (XferSize)
                                                          This field contains the transfer size in bytes for the current
                                                          endpoint.
                                                          The core only interrupts the application after it has exhausted
@@ -616,13 +599,13 @@ union cvmx_usbcx_dieptsizx
                                                          IN Endpoints: The core decrements this field every time a
                                                          packet from the external memory is written to the TxFIFO. */
 	} s;
-	struct cvmx_usbcx_dieptsizx_s         cn30xx;
-	struct cvmx_usbcx_dieptsizx_s         cn31xx;
-	struct cvmx_usbcx_dieptsizx_s         cn50xx;
-	struct cvmx_usbcx_dieptsizx_s         cn52xx;
-	struct cvmx_usbcx_dieptsizx_s         cn52xxp1;
-	struct cvmx_usbcx_dieptsizx_s         cn56xx;
-	struct cvmx_usbcx_dieptsizx_s         cn56xxp1;
+	struct cvmx_usbcx_dieptsizx_s cn30xx;
+	struct cvmx_usbcx_dieptsizx_s cn31xx;
+	struct cvmx_usbcx_dieptsizx_s cn50xx;
+	struct cvmx_usbcx_dieptsizx_s cn52xx;
+	struct cvmx_usbcx_dieptsizx_s cn52xxp1;
+	struct cvmx_usbcx_dieptsizx_s cn56xx;
+	struct cvmx_usbcx_dieptsizx_s cn56xxp1;
 };
 typedef union cvmx_usbcx_dieptsizx cvmx_usbcx_dieptsizx_t;
 
@@ -633,12 +616,10 @@ typedef union cvmx_usbcx_dieptsizx cvmx_usbcx_dieptsizx_t;
  *
  * The application uses the register to control the behaviour of each logical endpoint other than endpoint 0.
  */
-union cvmx_usbcx_doepctlx
-{
+union cvmx_usbcx_doepctlx {
 	uint32_t u32;
-	struct cvmx_usbcx_doepctlx_s
-	{
-	uint32_t epena                        : 1;  /**< Endpoint Enable (EPEna)
+	struct cvmx_usbcx_doepctlx_s {
+		uint32_t epena:1;		    /**< Endpoint Enable (EPEna)
                                                          Indicates that the application has allocated the memory tp start
                                                          receiving data from the USB.
                                                          The core clears this bit before setting any of the following
@@ -648,7 +629,7 @@ union cvmx_usbcx_doepctlx
                                                          * Transfer Completed
                                                          For control OUT endpoints in DMA mode, this bit must be set
                                                          to be able to transfer SETUP data packets in memory. */
-	uint32_t epdis                        : 1;  /**< Endpoint Disable (EPDis)
+		uint32_t epdis:1;		    /**< Endpoint Disable (EPDis)
                                                          The application sets this bit to stop transmitting data on an
                                                          endpoint, even before the transfer for that endpoint is complete.
                                                          The application must wait for the Endpoint Disabled interrupt
@@ -656,7 +637,7 @@ union cvmx_usbcx_doepctlx
                                                          before setting the Endpoint Disabled Interrupt. The application
                                                          should set this bit only if Endpoint Enable is already set for this
                                                          endpoint. */
-	uint32_t setd1pid                     : 1;  /**< For Interrupt/BULK enpoints:
+		uint32_t setd1pid:1;		    /**< For Interrupt/BULK enpoints:
                                                           Set DATA1 PID (SetD1PID)
                                                           Writing to this field sets the Endpoint Data Pid (DPID) field in
                                                           this register to DATA1.
@@ -664,23 +645,23 @@ union cvmx_usbcx_doepctlx
                                                           Set Odd (micro)frame (SetOddFr)
                                                           Writing to this field sets the Even/Odd (micro)frame (EO_FrNum)
                                                           field to odd (micro)frame. */
-	uint32_t setd0pid                     : 1;  /**< For Interrupt/BULK enpoints:
+		uint32_t setd0pid:1;		    /**< For Interrupt/BULK enpoints:
                                                           Writing to this field sets the Endpoint Data Pid (DPID) field in
                                                           this register to DATA0.
                                                          For Isochronous endpoints:
                                                           Set Odd (micro)frame (SetEvenFr)
                                                           Writing to this field sets the Even/Odd (micro)frame (EO_FrNum)
                                                           field to even (micro)frame. */
-	uint32_t snak                         : 1;  /**< Set NAK (SNAK)
+		uint32_t snak:1;		    /**< Set NAK (SNAK)
                                                          A write to this bit sets the NAK bit for the endpoint.
                                                          Using this bit, the application can control the transmission of
                                                          NAK handshakes on an endpoint. The core can also set this bit
                                                          for an endpoint after a SETUP packet is received on the
                                                          endpoint. */
-	uint32_t cnak                         : 1;  /**< Clear NAK (CNAK)
+		uint32_t cnak:1;		    /**< Clear NAK (CNAK)
                                                          A write to this bit clears the NAK bit for the endpoint. */
-	uint32_t reserved_22_25               : 4;
-	uint32_t stall                        : 1;  /**< STALL Handshake (Stall)
+		uint32_t reserved_22_25:4;
+		uint32_t stall:1;		    /**< STALL Handshake (Stall)
                                                          For non-control, non-isochronous endpoints:
                                                           The application sets this bit to stall all tokens from the USB host
                                                           to this endpoint.  If a NAK bit, Global Non-Periodic IN NAK, or
@@ -692,17 +673,17 @@ union cvmx_usbcx_doepctlx
                                                           Non-Periodic IN NAK, or Global OUT NAK is set along with this
                                                           bit, the STALL bit takes priority.  Irrespective of this bit's setting,
                                                           the core always responds to SETUP data packets with an ACK handshake. */
-	uint32_t snp                          : 1;  /**< Snoop Mode (Snp)
+		uint32_t snp:1;			    /**< Snoop Mode (Snp)
                                                          This bit configures the endpoint to Snoop mode.  In Snoop mode,
                                                          the core does not check the correctness of OUT packets before
                                                          transferring them to application memory. */
-	uint32_t eptype                       : 2;  /**< Endpoint Type (EPType)
+		uint32_t eptype:2;		    /**< Endpoint Type (EPType)
                                                          This is the transfer type supported by this logical endpoint.
                                                          * 2'b00: Control
                                                          * 2'b01: Isochronous
                                                          * 2'b10: Bulk
                                                          * 2'b11: Interrupt */
-	uint32_t naksts                       : 1;  /**< NAK Status (NAKSts)
+		uint32_t naksts:1;		    /**< NAK Status (NAKSts)
                                                          Indicates the following:
                                                          * 1'b0: The core is transmitting non-NAK handshakes based
                                                                  on the FIFO status
@@ -712,7 +693,7 @@ union cvmx_usbcx_doepctlx
                                                          * The core stops receiving any data on an OUT endpoint, even
                                                            if there is space in the RxFIFO to accomodate the incoming
                                                            packet. */
-	uint32_t dpid                         : 1;  /**< For interrupt/bulk IN and OUT endpoints:
+		uint32_t dpid:1;		    /**< For interrupt/bulk IN and OUT endpoints:
                                                           Endpoint Data PID (DPID)
                                                           Contains the PID of the packet to be received or transmitted on
                                                           this endpoint.  The application should program the PID of the first
@@ -731,27 +712,27 @@ union cvmx_usbcx_doepctlx
                                                           using the SetEvnFr and SetOddFr fields in this register.
                                                           * 1'b0: Even (micro)frame
                                                           * 1'b1: Odd (micro)frame */
-	uint32_t usbactep                     : 1;  /**< USB Active Endpoint (USBActEP)
+		uint32_t usbactep:1;		    /**< USB Active Endpoint (USBActEP)
                                                          Indicates whether this endpoint is active in the current
                                                          configuration and interface.  The core clears this bit for all
                                                          endpoints (other than EP 0) after detecting a USB reset.  After
                                                          receiving the SetConfiguration and SetInterface commands, the
                                                          application must program endpoint registers accordingly and set
                                                          this bit. */
-	uint32_t reserved_11_14               : 4;
-	uint32_t mps                          : 11; /**< Maximum Packet Size (MPS)
+		uint32_t reserved_11_14:4;
+		uint32_t mps:11;		    /**< Maximum Packet Size (MPS)
                                                          Applies to IN and OUT endpoints.
                                                          The application must program this field with the maximum
                                                          packet size for the current logical endpoint.  This value is in
                                                          bytes. */
 	} s;
-	struct cvmx_usbcx_doepctlx_s          cn30xx;
-	struct cvmx_usbcx_doepctlx_s          cn31xx;
-	struct cvmx_usbcx_doepctlx_s          cn50xx;
-	struct cvmx_usbcx_doepctlx_s          cn52xx;
-	struct cvmx_usbcx_doepctlx_s          cn52xxp1;
-	struct cvmx_usbcx_doepctlx_s          cn56xx;
-	struct cvmx_usbcx_doepctlx_s          cn56xxp1;
+	struct cvmx_usbcx_doepctlx_s cn30xx;
+	struct cvmx_usbcx_doepctlx_s cn31xx;
+	struct cvmx_usbcx_doepctlx_s cn50xx;
+	struct cvmx_usbcx_doepctlx_s cn52xx;
+	struct cvmx_usbcx_doepctlx_s cn52xxp1;
+	struct cvmx_usbcx_doepctlx_s cn56xx;
+	struct cvmx_usbcx_doepctlx_s cn56xxp1;
 };
 typedef union cvmx_usbcx_doepctlx cvmx_usbcx_doepctlx_t;
 
@@ -768,42 +749,40 @@ typedef union cvmx_usbcx_doepctlx cvmx_usbcx_doepctlx_t;
  * Interrupt register. The application must clear the appropriate bit in this register to clear the
  * corresponding bits in the DAINT and GINTSTS registers.
  */
-union cvmx_usbcx_doepintx
-{
+union cvmx_usbcx_doepintx {
 	uint32_t u32;
-	struct cvmx_usbcx_doepintx_s
-	{
-	uint32_t reserved_5_31                : 27;
-	uint32_t outtknepdis                  : 1;  /**< OUT Token Received When Endpoint Disabled (OUTTknEPdis)
+	struct cvmx_usbcx_doepintx_s {
+		uint32_t reserved_5_31:27;
+		uint32_t outtknepdis:1;		    /**< OUT Token Received When Endpoint Disabled (OUTTknEPdis)
                                                          Applies only to control OUT endpoints.
                                                          Indicates that an OUT token was received when the endpoint
                                                          was not yet enabled. This interrupt is asserted on the endpoint
                                                          for which the OUT token was received. */
-	uint32_t setup                        : 1;  /**< SETUP Phase Done (SetUp)
+		uint32_t setup:1;		    /**< SETUP Phase Done (SetUp)
                                                          Applies to control OUT endpoints only.
                                                          Indicates that the SETUP phase for the control endpoint is
                                                          complete and no more back-to-back SETUP packets were
                                                          received for the current control transfer. On this interrupt, the
                                                          application can decode the received SETUP data packet. */
-	uint32_t ahberr                       : 1;  /**< AHB Error (AHBErr)
+		uint32_t ahberr:1;		    /**< AHB Error (AHBErr)
                                                          This is generated only in Internal DMA mode when there is an
                                                          AHB error during an AHB read/write. The application can read
                                                          the corresponding endpoint DMA address register to get the
                                                          error address. */
-	uint32_t epdisbld                     : 1;  /**< Endpoint Disabled Interrupt (EPDisbld)
+		uint32_t epdisbld:1;		    /**< Endpoint Disabled Interrupt (EPDisbld)
                                                          This bit indicates that the endpoint is disabled per the
                                                          application's request. */
-	uint32_t xfercompl                    : 1;  /**< Transfer Completed Interrupt (XferCompl)
+		uint32_t xfercompl:1;		    /**< Transfer Completed Interrupt (XferCompl)
                                                          Indicates that the programmed transfer is complete on the AHB
                                                          as well as on the USB, for this endpoint. */
 	} s;
-	struct cvmx_usbcx_doepintx_s          cn30xx;
-	struct cvmx_usbcx_doepintx_s          cn31xx;
-	struct cvmx_usbcx_doepintx_s          cn50xx;
-	struct cvmx_usbcx_doepintx_s          cn52xx;
-	struct cvmx_usbcx_doepintx_s          cn52xxp1;
-	struct cvmx_usbcx_doepintx_s          cn56xx;
-	struct cvmx_usbcx_doepintx_s          cn56xxp1;
+	struct cvmx_usbcx_doepintx_s cn30xx;
+	struct cvmx_usbcx_doepintx_s cn31xx;
+	struct cvmx_usbcx_doepintx_s cn50xx;
+	struct cvmx_usbcx_doepintx_s cn52xx;
+	struct cvmx_usbcx_doepintx_s cn52xxp1;
+	struct cvmx_usbcx_doepintx_s cn56xx;
+	struct cvmx_usbcx_doepintx_s cn56xxp1;
 };
 typedef union cvmx_usbcx_doepintx cvmx_usbcx_doepintx_t;
 
@@ -818,28 +797,26 @@ typedef union cvmx_usbcx_doepintx cvmx_usbcx_doepintx_t;
  * corresponding bit in this register. Status bits are masked by default.
  * Mask interrupt: 1'b0 Unmask interrupt: 1'b1
  */
-union cvmx_usbcx_doepmsk
-{
+union cvmx_usbcx_doepmsk {
 	uint32_t u32;
-	struct cvmx_usbcx_doepmsk_s
-	{
-	uint32_t reserved_5_31                : 27;
-	uint32_t outtknepdismsk               : 1;  /**< OUT Token Received when Endpoint Disabled Mask
+	struct cvmx_usbcx_doepmsk_s {
+		uint32_t reserved_5_31:27;
+		uint32_t outtknepdismsk:1;	    /**< OUT Token Received when Endpoint Disabled Mask
                                                          (OUTTknEPdisMsk)
                                                          Applies to control OUT endpoints only. */
-	uint32_t setupmsk                     : 1;  /**< SETUP Phase Done Mask (SetUPMsk)
+		uint32_t setupmsk:1;		    /**< SETUP Phase Done Mask (SetUPMsk)
                                                          Applies to control endpoints only. */
-	uint32_t ahberrmsk                    : 1;  /**< AHB Error (AHBErrMsk) */
-	uint32_t epdisbldmsk                  : 1;  /**< Endpoint Disabled Interrupt Mask (EPDisbldMsk) */
-	uint32_t xfercomplmsk                 : 1;  /**< Transfer Completed Interrupt Mask (XferComplMsk) */
+		uint32_t ahberrmsk:1;		    /**< AHB Error (AHBErrMsk) */
+		uint32_t epdisbldmsk:1;		    /**< Endpoint Disabled Interrupt Mask (EPDisbldMsk) */
+		uint32_t xfercomplmsk:1;	    /**< Transfer Completed Interrupt Mask (XferComplMsk) */
 	} s;
-	struct cvmx_usbcx_doepmsk_s           cn30xx;
-	struct cvmx_usbcx_doepmsk_s           cn31xx;
-	struct cvmx_usbcx_doepmsk_s           cn50xx;
-	struct cvmx_usbcx_doepmsk_s           cn52xx;
-	struct cvmx_usbcx_doepmsk_s           cn52xxp1;
-	struct cvmx_usbcx_doepmsk_s           cn56xx;
-	struct cvmx_usbcx_doepmsk_s           cn56xxp1;
+	struct cvmx_usbcx_doepmsk_s cn30xx;
+	struct cvmx_usbcx_doepmsk_s cn31xx;
+	struct cvmx_usbcx_doepmsk_s cn50xx;
+	struct cvmx_usbcx_doepmsk_s cn52xx;
+	struct cvmx_usbcx_doepmsk_s cn52xxp1;
+	struct cvmx_usbcx_doepmsk_s cn56xx;
+	struct cvmx_usbcx_doepmsk_s cn56xxp1;
 };
 typedef union cvmx_usbcx_doepmsk cvmx_usbcx_doepmsk_t;
 
@@ -854,13 +831,11 @@ typedef union cvmx_usbcx_doepmsk cvmx_usbcx_doepmsk_t;
  * can only read this register once the core has cleared the Endpoint Enable bit.
  * This register is used only for endpoints other than Endpoint 0.
  */
-union cvmx_usbcx_doeptsizx
-{
+union cvmx_usbcx_doeptsizx {
 	uint32_t u32;
-	struct cvmx_usbcx_doeptsizx_s
-	{
-	uint32_t reserved_31_31               : 1;
-	uint32_t mc                           : 2;  /**< Multi Count (MC)
+	struct cvmx_usbcx_doeptsizx_s {
+		uint32_t reserved_31_31:1;
+		uint32_t mc:2;			    /**< Multi Count (MC)
                                                          Received Data PID (RxDPID)
                                                          Applies to isochronous OUT endpoints only.
                                                          This is the data PID received in the last packet for this endpoint.
@@ -875,13 +850,13 @@ union cvmx_usbcx_doeptsizx
                                                          2'b01: 1 packet
                                                          2'b10: 2 packets
                                                          2'b11: 3 packets */
-	uint32_t pktcnt                       : 10; /**< Packet Count (PktCnt)
+		uint32_t pktcnt:10;		    /**< Packet Count (PktCnt)
                                                          Indicates the total number of USB packets that constitute the
                                                          Transfer Size amount of data for this endpoint.
                                                          OUT Endpoints: This field is decremented every time a
                                                          packet (maximum size or short packet) is written to the
                                                          RxFIFO. */
-	uint32_t xfersize                     : 19; /**< Transfer Size (XferSize)
+		uint32_t xfersize:19;		    /**< Transfer Size (XferSize)
                                                          This field contains the transfer size in bytes for the current
                                                          endpoint.
                                                          The core only interrupts the application after it has exhausted
@@ -892,13 +867,13 @@ union cvmx_usbcx_doeptsizx
                                                          packet is read from the RxFIFO and written to the external
                                                          memory. */
 	} s;
-	struct cvmx_usbcx_doeptsizx_s         cn30xx;
-	struct cvmx_usbcx_doeptsizx_s         cn31xx;
-	struct cvmx_usbcx_doeptsizx_s         cn50xx;
-	struct cvmx_usbcx_doeptsizx_s         cn52xx;
-	struct cvmx_usbcx_doeptsizx_s         cn52xxp1;
-	struct cvmx_usbcx_doeptsizx_s         cn56xx;
-	struct cvmx_usbcx_doeptsizx_s         cn56xxp1;
+	struct cvmx_usbcx_doeptsizx_s cn30xx;
+	struct cvmx_usbcx_doeptsizx_s cn31xx;
+	struct cvmx_usbcx_doeptsizx_s cn50xx;
+	struct cvmx_usbcx_doeptsizx_s cn52xx;
+	struct cvmx_usbcx_doeptsizx_s cn52xxp1;
+	struct cvmx_usbcx_doeptsizx_s cn56xx;
+	struct cvmx_usbcx_doeptsizx_s cn56xxp1;
 };
 typedef union cvmx_usbcx_doeptsizx cvmx_usbcx_doeptsizx_t;
 
@@ -911,25 +886,23 @@ typedef union cvmx_usbcx_doeptsizx cvmx_usbcx_doeptsizx_t;
  * in Device mode. Each periodic FIFO holds the data for one periodic IN endpoint.
  * This register is repeated for each periodic FIFO instantiated.
  */
-union cvmx_usbcx_dptxfsizx
-{
+union cvmx_usbcx_dptxfsizx {
 	uint32_t u32;
-	struct cvmx_usbcx_dptxfsizx_s
-	{
-	uint32_t dptxfsize                    : 16; /**< Device Periodic TxFIFO Size (DPTxFSize)
+	struct cvmx_usbcx_dptxfsizx_s {
+		uint32_t dptxfsize:16;		    /**< Device Periodic TxFIFO Size (DPTxFSize)
                                                          This value is in terms of 32-bit words.
                                                          * Minimum value is 4
                                                          * Maximum value is 768 */
-	uint32_t dptxfstaddr                  : 16; /**< Device Periodic TxFIFO RAM Start Address (DPTxFStAddr)
+		uint32_t dptxfstaddr:16;	    /**< Device Periodic TxFIFO RAM Start Address (DPTxFStAddr)
                                                          Holds the start address in the RAM for this periodic FIFO. */
 	} s;
-	struct cvmx_usbcx_dptxfsizx_s         cn30xx;
-	struct cvmx_usbcx_dptxfsizx_s         cn31xx;
-	struct cvmx_usbcx_dptxfsizx_s         cn50xx;
-	struct cvmx_usbcx_dptxfsizx_s         cn52xx;
-	struct cvmx_usbcx_dptxfsizx_s         cn52xxp1;
-	struct cvmx_usbcx_dptxfsizx_s         cn56xx;
-	struct cvmx_usbcx_dptxfsizx_s         cn56xxp1;
+	struct cvmx_usbcx_dptxfsizx_s cn30xx;
+	struct cvmx_usbcx_dptxfsizx_s cn31xx;
+	struct cvmx_usbcx_dptxfsizx_s cn50xx;
+	struct cvmx_usbcx_dptxfsizx_s cn52xx;
+	struct cvmx_usbcx_dptxfsizx_s cn52xxp1;
+	struct cvmx_usbcx_dptxfsizx_s cn56xx;
+	struct cvmx_usbcx_dptxfsizx_s cn56xxp1;
 };
 typedef union cvmx_usbcx_dptxfsizx cvmx_usbcx_dptxfsizx_t;
 
@@ -941,18 +914,16 @@ typedef union cvmx_usbcx_dptxfsizx cvmx_usbcx_dptxfsizx_t;
  * This register indicates the status of the core with respect to USB-related events.
  * It must be read on interrupts from Device All Interrupts (DAINT) register.
  */
-union cvmx_usbcx_dsts
-{
+union cvmx_usbcx_dsts {
 	uint32_t u32;
-	struct cvmx_usbcx_dsts_s
-	{
-	uint32_t reserved_22_31               : 10;
-	uint32_t soffn                        : 14; /**< Frame or Microframe Number of the Received SOF (SOFFN)
+	struct cvmx_usbcx_dsts_s {
+		uint32_t reserved_22_31:10;
+		uint32_t soffn:14;		    /**< Frame or Microframe Number of the Received SOF (SOFFN)
                                                          When the core is operating at high speed, this field contains a
                                                          microframe number. When the core is operating at full or low
                                                          speed, this field contains a frame number. */
-	uint32_t reserved_4_7                 : 4;
-	uint32_t errticerr                    : 1;  /**< Erratic Error (ErrticErr)
+		uint32_t reserved_4_7:4;
+		uint32_t errticerr:1;		    /**< Erratic Error (ErrticErr)
                                                          The core sets this bit to report any erratic errors
                                                          (phy_rxvalid_i/phy_rxvldh_i or phy_rxactive_i is asserted for at
                                                          least 2 ms, due to PHY error) seen on the UTMI+.
@@ -961,7 +932,7 @@ union cvmx_usbcx_dsts
                                                          Suspend bit of the Core Interrupt register (GINTSTS.ErlySusp).
                                                          If the early suspend is asserted due to an erratic error, the
                                                          application can only perform a soft disconnect recover. */
-	uint32_t enumspd                      : 2;  /**< Enumerated Speed (EnumSpd)
+		uint32_t enumspd:2;		    /**< Enumerated Speed (EnumSpd)
                                                          Indicates the speed at which the O2P USB core has come up
                                                          after speed detection through a chirp sequence.
                                                          * 2'b00: High speed (PHY clock is running at 30 or 60 MHz)
@@ -969,7 +940,7 @@ union cvmx_usbcx_dsts
                                                          * 2'b10: Low speed (PHY clock is running at 6 MHz)
                                                          * 2'b11: Full speed (PHY clock is running at 48 MHz)
                                                          Low speed is not supported for devices using a UTMI+ PHY. */
-	uint32_t suspsts                      : 1;  /**< Suspend Status (SuspSts)
+		uint32_t suspsts:1;		    /**< Suspend Status (SuspSts)
                                                          In Device mode, this bit is set as long as a Suspend condition is
                                                          detected on the USB. The core enters the Suspended state
                                                          when there is no activity on the phy_line_state_i signal for an
@@ -978,13 +949,13 @@ union cvmx_usbcx_dsts
                                                          * When the application writes to the Remote Wakeup Signaling
                                                            bit in the Device Control register (DCTL.RmtWkUpSig). */
 	} s;
-	struct cvmx_usbcx_dsts_s              cn30xx;
-	struct cvmx_usbcx_dsts_s              cn31xx;
-	struct cvmx_usbcx_dsts_s              cn50xx;
-	struct cvmx_usbcx_dsts_s              cn52xx;
-	struct cvmx_usbcx_dsts_s              cn52xxp1;
-	struct cvmx_usbcx_dsts_s              cn56xx;
-	struct cvmx_usbcx_dsts_s              cn56xxp1;
+	struct cvmx_usbcx_dsts_s cn30xx;
+	struct cvmx_usbcx_dsts_s cn31xx;
+	struct cvmx_usbcx_dsts_s cn50xx;
+	struct cvmx_usbcx_dsts_s cn52xx;
+	struct cvmx_usbcx_dsts_s cn52xxp1;
+	struct cvmx_usbcx_dsts_s cn56xx;
+	struct cvmx_usbcx_dsts_s cn56xxp1;
 };
 typedef union cvmx_usbcx_dsts cvmx_usbcx_dsts_t;
 
@@ -999,31 +970,29 @@ typedef union cvmx_usbcx_dsts cvmx_usbcx_dsts_t;
  * Learning Queue. When the queue is full, the new token is pushed into the queue and oldest
  * token is discarded.
  */
-union cvmx_usbcx_dtknqr1
-{
+union cvmx_usbcx_dtknqr1 {
 	uint32_t u32;
-	struct cvmx_usbcx_dtknqr1_s
-	{
-	uint32_t eptkn                        : 24; /**< Endpoint Token (EPTkn)
+	struct cvmx_usbcx_dtknqr1_s {
+		uint32_t eptkn:24;		    /**< Endpoint Token (EPTkn)
                                                          Four bits per token represent the endpoint number of the token:
                                                          * Bits [31:28]: Endpoint number of Token 5
                                                          * Bits [27:24]: Endpoint number of Token 4
                                                          - .......
                                                          * Bits [15:12]: Endpoint number of Token 1
                                                          * Bits [11:8]: Endpoint number of Token 0 */
-	uint32_t wrapbit                      : 1;  /**< Wrap Bit (WrapBit)
+		uint32_t wrapbit:1;		    /**< Wrap Bit (WrapBit)
                                                          This bit is set when the write pointer wraps. It is cleared when
                                                          the learning queue is cleared. */
-	uint32_t reserved_5_6                 : 2;
-	uint32_t intknwptr                    : 5;  /**< IN Token Queue Write Pointer (INTknWPtr) */
+		uint32_t reserved_5_6:2;
+		uint32_t intknwptr:5;		    /**< IN Token Queue Write Pointer (INTknWPtr) */
 	} s;
-	struct cvmx_usbcx_dtknqr1_s           cn30xx;
-	struct cvmx_usbcx_dtknqr1_s           cn31xx;
-	struct cvmx_usbcx_dtknqr1_s           cn50xx;
-	struct cvmx_usbcx_dtknqr1_s           cn52xx;
-	struct cvmx_usbcx_dtknqr1_s           cn52xxp1;
-	struct cvmx_usbcx_dtknqr1_s           cn56xx;
-	struct cvmx_usbcx_dtknqr1_s           cn56xxp1;
+	struct cvmx_usbcx_dtknqr1_s cn30xx;
+	struct cvmx_usbcx_dtknqr1_s cn31xx;
+	struct cvmx_usbcx_dtknqr1_s cn50xx;
+	struct cvmx_usbcx_dtknqr1_s cn52xx;
+	struct cvmx_usbcx_dtknqr1_s cn52xxp1;
+	struct cvmx_usbcx_dtknqr1_s cn56xx;
+	struct cvmx_usbcx_dtknqr1_s cn56xxp1;
 };
 typedef union cvmx_usbcx_dtknqr1 cvmx_usbcx_dtknqr1_t;
 
@@ -1034,12 +1003,10 @@ typedef union cvmx_usbcx_dtknqr1 cvmx_usbcx_dtknqr1_t;
  *
  * A read from this register returns the next 8 endpoint entries of the learning queue.
  */
-union cvmx_usbcx_dtknqr2
-{
+union cvmx_usbcx_dtknqr2 {
 	uint32_t u32;
-	struct cvmx_usbcx_dtknqr2_s
-	{
-	uint32_t eptkn                        : 32; /**< Endpoint Token (EPTkn)
+	struct cvmx_usbcx_dtknqr2_s {
+		uint32_t eptkn:32;		    /**< Endpoint Token (EPTkn)
                                                          Four bits per token represent the endpoint number of the token:
                                                          * Bits [31:28]: Endpoint number of Token 13
                                                          * Bits [27:24]: Endpoint number of Token 12
@@ -1047,13 +1014,13 @@ union cvmx_usbcx_dtknqr2
                                                          * Bits [7:4]: Endpoint number of Token 7
                                                          * Bits [3:0]: Endpoint number of Token 6 */
 	} s;
-	struct cvmx_usbcx_dtknqr2_s           cn30xx;
-	struct cvmx_usbcx_dtknqr2_s           cn31xx;
-	struct cvmx_usbcx_dtknqr2_s           cn50xx;
-	struct cvmx_usbcx_dtknqr2_s           cn52xx;
-	struct cvmx_usbcx_dtknqr2_s           cn52xxp1;
-	struct cvmx_usbcx_dtknqr2_s           cn56xx;
-	struct cvmx_usbcx_dtknqr2_s           cn56xxp1;
+	struct cvmx_usbcx_dtknqr2_s cn30xx;
+	struct cvmx_usbcx_dtknqr2_s cn31xx;
+	struct cvmx_usbcx_dtknqr2_s cn50xx;
+	struct cvmx_usbcx_dtknqr2_s cn52xx;
+	struct cvmx_usbcx_dtknqr2_s cn52xxp1;
+	struct cvmx_usbcx_dtknqr2_s cn56xx;
+	struct cvmx_usbcx_dtknqr2_s cn56xxp1;
 };
 typedef union cvmx_usbcx_dtknqr2 cvmx_usbcx_dtknqr2_t;
 
@@ -1064,12 +1031,10 @@ typedef union cvmx_usbcx_dtknqr2 cvmx_usbcx_dtknqr2_t;
  *
  * A read from this register returns the next 8 endpoint entries of the learning queue.
  */
-union cvmx_usbcx_dtknqr3
-{
+union cvmx_usbcx_dtknqr3 {
 	uint32_t u32;
-	struct cvmx_usbcx_dtknqr3_s
-	{
-	uint32_t eptkn                        : 32; /**< Endpoint Token (EPTkn)
+	struct cvmx_usbcx_dtknqr3_s {
+		uint32_t eptkn:32;		    /**< Endpoint Token (EPTkn)
                                                          Four bits per token represent the endpoint number of the token:
                                                          * Bits [31:28]: Endpoint number of Token 21
                                                          * Bits [27:24]: Endpoint number of Token 20
@@ -1077,13 +1042,13 @@ union cvmx_usbcx_dtknqr3
                                                          * Bits [7:4]: Endpoint number of Token 15
                                                          * Bits [3:0]: Endpoint number of Token 14 */
 	} s;
-	struct cvmx_usbcx_dtknqr3_s           cn30xx;
-	struct cvmx_usbcx_dtknqr3_s           cn31xx;
-	struct cvmx_usbcx_dtknqr3_s           cn50xx;
-	struct cvmx_usbcx_dtknqr3_s           cn52xx;
-	struct cvmx_usbcx_dtknqr3_s           cn52xxp1;
-	struct cvmx_usbcx_dtknqr3_s           cn56xx;
-	struct cvmx_usbcx_dtknqr3_s           cn56xxp1;
+	struct cvmx_usbcx_dtknqr3_s cn30xx;
+	struct cvmx_usbcx_dtknqr3_s cn31xx;
+	struct cvmx_usbcx_dtknqr3_s cn50xx;
+	struct cvmx_usbcx_dtknqr3_s cn52xx;
+	struct cvmx_usbcx_dtknqr3_s cn52xxp1;
+	struct cvmx_usbcx_dtknqr3_s cn56xx;
+	struct cvmx_usbcx_dtknqr3_s cn56xxp1;
 };
 typedef union cvmx_usbcx_dtknqr3 cvmx_usbcx_dtknqr3_t;
 
@@ -1094,12 +1059,10 @@ typedef union cvmx_usbcx_dtknqr3 cvmx_usbcx_dtknqr3_t;
  *
  * A read from this register returns the last 8 endpoint entries of the learning queue.
  */
-union cvmx_usbcx_dtknqr4
-{
+union cvmx_usbcx_dtknqr4 {
 	uint32_t u32;
-	struct cvmx_usbcx_dtknqr4_s
-	{
-	uint32_t eptkn                        : 32; /**< Endpoint Token (EPTkn)
+	struct cvmx_usbcx_dtknqr4_s {
+		uint32_t eptkn:32;		    /**< Endpoint Token (EPTkn)
                                                          Four bits per token represent the endpoint number of the token:
                                                          * Bits [31:28]: Endpoint number of Token 29
                                                          * Bits [27:24]: Endpoint number of Token 28
@@ -1107,13 +1070,13 @@ union cvmx_usbcx_dtknqr4
                                                          * Bits [7:4]: Endpoint number of Token 23
                                                          * Bits [3:0]: Endpoint number of Token 22 */
 	} s;
-	struct cvmx_usbcx_dtknqr4_s           cn30xx;
-	struct cvmx_usbcx_dtknqr4_s           cn31xx;
-	struct cvmx_usbcx_dtknqr4_s           cn50xx;
-	struct cvmx_usbcx_dtknqr4_s           cn52xx;
-	struct cvmx_usbcx_dtknqr4_s           cn52xxp1;
-	struct cvmx_usbcx_dtknqr4_s           cn56xx;
-	struct cvmx_usbcx_dtknqr4_s           cn56xxp1;
+	struct cvmx_usbcx_dtknqr4_s cn30xx;
+	struct cvmx_usbcx_dtknqr4_s cn31xx;
+	struct cvmx_usbcx_dtknqr4_s cn50xx;
+	struct cvmx_usbcx_dtknqr4_s cn52xx;
+	struct cvmx_usbcx_dtknqr4_s cn52xxp1;
+	struct cvmx_usbcx_dtknqr4_s cn56xx;
+	struct cvmx_usbcx_dtknqr4_s cn56xxp1;
 };
 typedef union cvmx_usbcx_dtknqr4 cvmx_usbcx_dtknqr4_t;
 
@@ -1130,13 +1093,11 @@ typedef union cvmx_usbcx_dtknqr4 cvmx_usbcx_dtknqr4_t;
  * The application must program this register as part of the O2P USB core initialization.
  * Do not change this register after the initial programming.
  */
-union cvmx_usbcx_gahbcfg
-{
+union cvmx_usbcx_gahbcfg {
 	uint32_t u32;
-	struct cvmx_usbcx_gahbcfg_s
-	{
-	uint32_t reserved_9_31                : 23;
-	uint32_t ptxfemplvl                   : 1;  /**< Periodic TxFIFO Empty Level (PTxFEmpLvl)
+	struct cvmx_usbcx_gahbcfg_s {
+		uint32_t reserved_9_31:23;
+		uint32_t ptxfemplvl:1;		    /**< Periodic TxFIFO Empty Level (PTxFEmpLvl)
                                                          Software should set this bit to 0x1.
                                                          Indicates when the Periodic TxFIFO Empty Interrupt bit in the
                                                          Core Interrupt register (GINTSTS.PTxFEmp) is triggered. This
@@ -1145,7 +1106,7 @@ union cvmx_usbcx_gahbcfg
                                                            TxFIFO is half empty
                                                          * 1'b1: GINTSTS.PTxFEmp interrupt indicates that the Periodic
                                                            TxFIFO is completely empty */
-	uint32_t nptxfemplvl                  : 1;  /**< Non-Periodic TxFIFO Empty Level (NPTxFEmpLvl)
+		uint32_t nptxfemplvl:1;		    /**< Non-Periodic TxFIFO Empty Level (NPTxFEmpLvl)
                                                          Software should set this bit to 0x1.
                                                          Indicates when the Non-Periodic TxFIFO Empty Interrupt bit in
                                                          the Core Interrupt register (GINTSTS.NPTxFEmp) is triggered.
@@ -1154,13 +1115,13 @@ union cvmx_usbcx_gahbcfg
                                                             Periodic TxFIFO is half empty
                                                          * 1'b1: GINTSTS.NPTxFEmp interrupt indicates that the Non-
                                                             Periodic TxFIFO is completely empty */
-	uint32_t reserved_6_6                 : 1;
-	uint32_t dmaen                        : 1;  /**< DMA Enable (DMAEn)
+		uint32_t reserved_6_6:1;
+		uint32_t dmaen:1;		    /**< DMA Enable (DMAEn)
                                                          * 1'b0: Core operates in Slave mode
                                                          * 1'b1: Core operates in a DMA mode */
-	uint32_t hbstlen                      : 4;  /**< Burst Length/Type (HBstLen)
+		uint32_t hbstlen:4;		    /**< Burst Length/Type (HBstLen)
                                                          This field has not effect and should be left as 0x0. */
-	uint32_t glblintrmsk                  : 1;  /**< Global Interrupt Mask (GlblIntrMsk)
+		uint32_t glblintrmsk:1;		    /**< Global Interrupt Mask (GlblIntrMsk)
                                                          Software should set this field to 0x1.
                                                          The application uses this bit to mask  or unmask the interrupt
                                                          line assertion to itself. Irrespective of this bit's setting, the
@@ -1168,13 +1129,13 @@ union cvmx_usbcx_gahbcfg
                                                          * 1'b0: Mask the interrupt assertion to the application.
                                                          * 1'b1: Unmask the interrupt assertion to the application. */
 	} s;
-	struct cvmx_usbcx_gahbcfg_s           cn30xx;
-	struct cvmx_usbcx_gahbcfg_s           cn31xx;
-	struct cvmx_usbcx_gahbcfg_s           cn50xx;
-	struct cvmx_usbcx_gahbcfg_s           cn52xx;
-	struct cvmx_usbcx_gahbcfg_s           cn52xxp1;
-	struct cvmx_usbcx_gahbcfg_s           cn56xx;
-	struct cvmx_usbcx_gahbcfg_s           cn56xxp1;
+	struct cvmx_usbcx_gahbcfg_s cn30xx;
+	struct cvmx_usbcx_gahbcfg_s cn31xx;
+	struct cvmx_usbcx_gahbcfg_s cn50xx;
+	struct cvmx_usbcx_gahbcfg_s cn52xx;
+	struct cvmx_usbcx_gahbcfg_s cn52xxp1;
+	struct cvmx_usbcx_gahbcfg_s cn56xx;
+	struct cvmx_usbcx_gahbcfg_s cn56xxp1;
 };
 typedef union cvmx_usbcx_gahbcfg cvmx_usbcx_gahbcfg_t;
 
@@ -1185,12 +1146,10 @@ typedef union cvmx_usbcx_gahbcfg cvmx_usbcx_gahbcfg_t;
  *
  * This register contains the logical endpoint direction(s) of the O2P USB core.
  */
-union cvmx_usbcx_ghwcfg1
-{
+union cvmx_usbcx_ghwcfg1 {
 	uint32_t u32;
-	struct cvmx_usbcx_ghwcfg1_s
-	{
-	uint32_t epdir                        : 32; /**< Endpoint Direction (epdir)
+	struct cvmx_usbcx_ghwcfg1_s {
+		uint32_t epdir:32;		    /**< Endpoint Direction (epdir)
                                                          Two bits per endpoint represent the direction.
                                                          * 2'b00: BIDIR (IN and OUT) endpoint
                                                          * 2'b01: IN endpoint
@@ -1202,13 +1161,13 @@ union cvmx_usbcx_ghwcfg1
                                                          Bits [3:2]: Endpoint 1 direction
                                                          Bits[1:0]: Endpoint 0 direction (always BIDIR) */
 	} s;
-	struct cvmx_usbcx_ghwcfg1_s           cn30xx;
-	struct cvmx_usbcx_ghwcfg1_s           cn31xx;
-	struct cvmx_usbcx_ghwcfg1_s           cn50xx;
-	struct cvmx_usbcx_ghwcfg1_s           cn52xx;
-	struct cvmx_usbcx_ghwcfg1_s           cn52xxp1;
-	struct cvmx_usbcx_ghwcfg1_s           cn56xx;
-	struct cvmx_usbcx_ghwcfg1_s           cn56xxp1;
+	struct cvmx_usbcx_ghwcfg1_s cn30xx;
+	struct cvmx_usbcx_ghwcfg1_s cn31xx;
+	struct cvmx_usbcx_ghwcfg1_s cn50xx;
+	struct cvmx_usbcx_ghwcfg1_s cn52xx;
+	struct cvmx_usbcx_ghwcfg1_s cn52xxp1;
+	struct cvmx_usbcx_ghwcfg1_s cn56xx;
+	struct cvmx_usbcx_ghwcfg1_s cn56xxp1;
 };
 typedef union cvmx_usbcx_ghwcfg1 cvmx_usbcx_ghwcfg1_t;
 
@@ -1219,60 +1178,58 @@ typedef union cvmx_usbcx_ghwcfg1 cvmx_usbcx_ghwcfg1_t;
  *
  * This register contains configuration options of the O2P USB core.
  */
-union cvmx_usbcx_ghwcfg2
-{
+union cvmx_usbcx_ghwcfg2 {
 	uint32_t u32;
-	struct cvmx_usbcx_ghwcfg2_s
-	{
-	uint32_t reserved_31_31               : 1;
-	uint32_t tknqdepth                    : 5;  /**< Device Mode IN Token Sequence Learning Queue Depth
+	struct cvmx_usbcx_ghwcfg2_s {
+		uint32_t reserved_31_31:1;
+		uint32_t tknqdepth:5;		    /**< Device Mode IN Token Sequence Learning Queue Depth
                                                          (TknQDepth)
                                                          Range: 0-30 */
-	uint32_t ptxqdepth                    : 2;  /**< Host Mode Periodic Request Queue Depth (PTxQDepth)
+		uint32_t ptxqdepth:2;		    /**< Host Mode Periodic Request Queue Depth (PTxQDepth)
                                                          * 2'b00: 2
                                                          * 2'b01: 4
                                                          * 2'b10: 8
                                                          * Others: Reserved */
-	uint32_t nptxqdepth                   : 2;  /**< Non-Periodic Request Queue Depth (NPTxQDepth)
+		uint32_t nptxqdepth:2;		    /**< Non-Periodic Request Queue Depth (NPTxQDepth)
                                                          * 2'b00: 2
                                                          * 2'b01: 4
                                                          * 2'b10: 8
                                                          * Others: Reserved */
-	uint32_t reserved_20_21               : 2;
-	uint32_t dynfifosizing                : 1;  /**< Dynamic FIFO Sizing Enabled (DynFifoSizing)
+		uint32_t reserved_20_21:2;
+		uint32_t dynfifosizing:1;	    /**< Dynamic FIFO Sizing Enabled (DynFifoSizing)
                                                          * 1'b0: No
                                                          * 1'b1: Yes */
-	uint32_t periosupport                 : 1;  /**< Periodic OUT Channels Supported in Host Mode
+		uint32_t periosupport:1;	    /**< Periodic OUT Channels Supported in Host Mode
                                                          (PerioSupport)
                                                          * 1'b0: No
                                                          * 1'b1: Yes */
-	uint32_t numhstchnl                   : 4;  /**< Number of Host Channels (NumHstChnl)
+		uint32_t numhstchnl:4;		    /**< Number of Host Channels (NumHstChnl)
                                                          Indicates the number of host channels supported by the core in
                                                          Host mode. The range of this field is 0-15: 0 specifies 1
                                                          channel, 15 specifies 16 channels. */
-	uint32_t numdeveps                    : 4;  /**< Number of Device Endpoints (NumDevEps)
+		uint32_t numdeveps:4;		    /**< Number of Device Endpoints (NumDevEps)
                                                          Indicates the number of device endpoints supported by the core
                                                          in Device mode in addition to control endpoint 0. The range of
                                                          this field is 1-15. */
-	uint32_t fsphytype                    : 2;  /**< Full-Speed PHY Interface Type (FSPhyType)
+		uint32_t fsphytype:2;		    /**< Full-Speed PHY Interface Type (FSPhyType)
                                                          * 2'b00: Full-speed interface not supported
                                                          * 2'b01: Dedicated full-speed interface
                                                          * 2'b10: FS pins shared with UTMI+ pins
                                                          * 2'b11: FS pins shared with ULPI pins */
-	uint32_t hsphytype                    : 2;  /**< High-Speed PHY Interface Type (HSPhyType)
+		uint32_t hsphytype:2;		    /**< High-Speed PHY Interface Type (HSPhyType)
                                                          * 2'b00: High-Speed interface not supported
                                                          * 2'b01: UTMI+
                                                          * 2'b10: ULPI
                                                          * 2'b11: UTMI+ and ULPI */
-	uint32_t singpnt                      : 1;  /**< Point-to-Point (SingPnt)
+		uint32_t singpnt:1;		    /**< Point-to-Point (SingPnt)
                                                          * 1'b0: Multi-point application
                                                          * 1'b1: Single-point application */
-	uint32_t otgarch                      : 2;  /**< Architecture (OtgArch)
+		uint32_t otgarch:2;		    /**< Architecture (OtgArch)
                                                          * 2'b00: Slave-Only
                                                          * 2'b01: External DMA
                                                          * 2'b10: Internal DMA
                                                          * Others: Reserved */
-	uint32_t otgmode                      : 3;  /**< Mode of Operation (OtgMode)
+		uint32_t otgmode:3;		    /**< Mode of Operation (OtgMode)
                                                          * 3'b000: HNP- and SRP-Capable OTG (Host & Device)
                                                          * 3'b001: SRP-Capable OTG (Host & Device)
                                                          * 3'b010: Non-HNP and Non-SRP Capable OTG (Host &
@@ -1283,13 +1240,13 @@ union cvmx_usbcx_ghwcfg2
                                                          * 3'b110: Non-OTG Host
                                                          * Others: Reserved */
 	} s;
-	struct cvmx_usbcx_ghwcfg2_s           cn30xx;
-	struct cvmx_usbcx_ghwcfg2_s           cn31xx;
-	struct cvmx_usbcx_ghwcfg2_s           cn50xx;
-	struct cvmx_usbcx_ghwcfg2_s           cn52xx;
-	struct cvmx_usbcx_ghwcfg2_s           cn52xxp1;
-	struct cvmx_usbcx_ghwcfg2_s           cn56xx;
-	struct cvmx_usbcx_ghwcfg2_s           cn56xxp1;
+	struct cvmx_usbcx_ghwcfg2_s cn30xx;
+	struct cvmx_usbcx_ghwcfg2_s cn31xx;
+	struct cvmx_usbcx_ghwcfg2_s cn50xx;
+	struct cvmx_usbcx_ghwcfg2_s cn52xx;
+	struct cvmx_usbcx_ghwcfg2_s cn52xxp1;
+	struct cvmx_usbcx_ghwcfg2_s cn56xx;
+	struct cvmx_usbcx_ghwcfg2_s cn56xxp1;
 };
 typedef union cvmx_usbcx_ghwcfg2 cvmx_usbcx_ghwcfg2_t;
 
@@ -1300,41 +1257,40 @@ typedef union cvmx_usbcx_ghwcfg2 cvmx_usbcx_ghwcfg2_t;
  *
  * This register contains the configuration options of the O2P USB core.
  */
-union cvmx_usbcx_ghwcfg3
-{
+union cvmx_usbcx_ghwcfg3 {
 	uint32_t u32;
-	struct cvmx_usbcx_ghwcfg3_s
-	{
-	uint32_t dfifodepth                   : 16; /**< DFIFO Depth (DfifoDepth)
+	struct cvmx_usbcx_ghwcfg3_s {
+		uint32_t dfifodepth:16;		    /**< DFIFO Depth (DfifoDepth)
                                                          This value is in terms of 32-bit words.
                                                          * Minimum value is 32
                                                          * Maximum value is 32768 */
-	uint32_t reserved_13_15               : 3;
-	uint32_t ahbphysync                   : 1;  /**< AHB and PHY Synchronous (AhbPhySync)
+		uint32_t reserved_13_15:3;
+		uint32_t ahbphysync:1;		    /**< AHB and PHY Synchronous (AhbPhySync)
                                                          Indicates whether AHB and PHY clocks are synchronous to
                                                          each other.
                                                          * 1'b0: No
                                                          * 1'b1: Yes
                                                          This bit is tied to 1. */
-	uint32_t rsttype                      : 1;  /**< Reset Style for Clocked always Blocks in RTL (RstType)
+		uint32_t rsttype:1;		    /**< Reset Style for Clocked always Blocks in RTL (RstType)
                                                          * 1'b0: Asynchronous reset is used in the core
                                                          * 1'b1: Synchronous reset is used in the core */
-	uint32_t optfeature                   : 1;  /**< Optional Features Removed (OptFeature)
+		uint32_t optfeature:1;		    /**< Optional Features Removed (OptFeature)
                                                          Indicates whether the User ID register, GPIO interface ports,
                                                          and SOF toggle and counter ports were removed for gate count
                                                          optimization. */
-	uint32_t vendor_control_interface_support : 1;/**< Vendor Control Interface Support
+		uint32_t vendor_control_interface_support:1;
+						      /**< Vendor Control Interface Support
                                                          * 1'b0: Vendor Control Interface is not available on the core.
                                                          * 1'b1: Vendor Control Interface is available. */
-	uint32_t i2c_selection                : 1;  /**< I2C Selection
+		uint32_t i2c_selection:1;	    /**< I2C Selection
                                                          * 1'b0: I2C Interface is not available on the core.
                                                          * 1'b1: I2C Interface is available on the core. */
-	uint32_t otgen                        : 1;  /**< OTG Function Enabled (OtgEn)
+		uint32_t otgen:1;		    /**< OTG Function Enabled (OtgEn)
                                                          The application uses this bit to indicate the O2P USB core's
                                                          OTG capabilities.
                                                          * 1'b0: Not OTG capable
                                                          * 1'b1: OTG Capable */
-	uint32_t pktsizewidth                 : 3;  /**< Width of Packet Size Counters (PktSizeWidth)
+		uint32_t pktsizewidth:3;	    /**< Width of Packet Size Counters (PktSizeWidth)
                                                          * 3'b000: 4 bits
                                                          * 3'b001: 5 bits
                                                          * 3'b010: 6 bits
@@ -1343,20 +1299,20 @@ union cvmx_usbcx_ghwcfg3
                                                          * 3'b101: 9 bits
                                                          * 3'b110: 10 bits
                                                          * Others: Reserved */
-	uint32_t xfersizewidth                : 4;  /**< Width of Transfer Size Counters (XferSizeWidth)
+		uint32_t xfersizewidth:4;	    /**< Width of Transfer Size Counters (XferSizeWidth)
                                                          * 4'b0000: 11 bits
                                                          * 4'b0001: 12 bits
                                                          - ...
                                                          * 4'b1000: 19 bits
                                                          * Others: Reserved */
 	} s;
-	struct cvmx_usbcx_ghwcfg3_s           cn30xx;
-	struct cvmx_usbcx_ghwcfg3_s           cn31xx;
-	struct cvmx_usbcx_ghwcfg3_s           cn50xx;
-	struct cvmx_usbcx_ghwcfg3_s           cn52xx;
-	struct cvmx_usbcx_ghwcfg3_s           cn52xxp1;
-	struct cvmx_usbcx_ghwcfg3_s           cn56xx;
-	struct cvmx_usbcx_ghwcfg3_s           cn56xxp1;
+	struct cvmx_usbcx_ghwcfg3_s cn30xx;
+	struct cvmx_usbcx_ghwcfg3_s cn31xx;
+	struct cvmx_usbcx_ghwcfg3_s cn50xx;
+	struct cvmx_usbcx_ghwcfg3_s cn52xx;
+	struct cvmx_usbcx_ghwcfg3_s cn52xxp1;
+	struct cvmx_usbcx_ghwcfg3_s cn56xx;
+	struct cvmx_usbcx_ghwcfg3_s cn56xxp1;
 };
 typedef union cvmx_usbcx_ghwcfg3 cvmx_usbcx_ghwcfg3_t;
 
@@ -1367,33 +1323,31 @@ typedef union cvmx_usbcx_ghwcfg3 cvmx_usbcx_ghwcfg3_t;
  *
  * This register contains the configuration options of the O2P USB core.
  */
-union cvmx_usbcx_ghwcfg4
-{
+union cvmx_usbcx_ghwcfg4 {
 	uint32_t u32;
-	struct cvmx_usbcx_ghwcfg4_s
-	{
-	uint32_t reserved_30_31               : 2;
-	uint32_t numdevmodinend               : 4;  /**< Enable dedicatd transmit FIFO for device IN endpoints. */
-	uint32_t endedtrfifo                  : 1;  /**< Enable dedicatd transmit FIFO for device IN endpoints. */
-	uint32_t sessendfltr                  : 1;  /**< "session_end" Filter Enabled (SessEndFltr)
+	struct cvmx_usbcx_ghwcfg4_s {
+		uint32_t reserved_30_31:2;
+		uint32_t numdevmodinend:4;	    /**< Enable dedicatd transmit FIFO for device IN endpoints. */
+		uint32_t endedtrfifo:1;		    /**< Enable dedicatd transmit FIFO for device IN endpoints. */
+		uint32_t sessendfltr:1;		    /**< "session_end" Filter Enabled (SessEndFltr)
                                                          * 1'b0: No filter
                                                          * 1'b1: Filter */
-	uint32_t bvalidfltr                   : 1;  /**< "b_valid" Filter Enabled (BValidFltr)
+		uint32_t bvalidfltr:1;		    /**< "b_valid" Filter Enabled (BValidFltr)
                                                          * 1'b0: No filter
                                                          * 1'b1: Filter */
-	uint32_t avalidfltr                   : 1;  /**< "a_valid" Filter Enabled (AValidFltr)
+		uint32_t avalidfltr:1;		    /**< "a_valid" Filter Enabled (AValidFltr)
                                                          * 1'b0: No filter
                                                          * 1'b1: Filter */
-	uint32_t vbusvalidfltr                : 1;  /**< "vbus_valid" Filter Enabled (VBusValidFltr)
+		uint32_t vbusvalidfltr:1;	    /**< "vbus_valid" Filter Enabled (VBusValidFltr)
                                                          * 1'b0: No filter
                                                          * 1'b1: Filter */
-	uint32_t iddgfltr                     : 1;  /**< "iddig" Filter Enable (IddgFltr)
+		uint32_t iddgfltr:1;		    /**< "iddig" Filter Enable (IddgFltr)
                                                          * 1'b0: No filter
                                                          * 1'b1: Filter */
-	uint32_t numctleps                    : 4;  /**< Number of Device Mode Control Endpoints in Addition to
+		uint32_t numctleps:4;		    /**< Number of Device Mode Control Endpoints in Addition to
                                                          Endpoint 0 (NumCtlEps)
                                                          Range: 1-15 */
-	uint32_t phydatawidth                 : 2;  /**< UTMI+ PHY/ULPI-to-Internal UTMI+ Wrapper Data Width
+		uint32_t phydatawidth:2;	    /**< UTMI+ PHY/ULPI-to-Internal UTMI+ Wrapper Data Width
                                                          (PhyDataWidth)
                                                          When a ULPI PHY is used, an internal wrapper converts ULPI
                                                          to UTMI+.
@@ -1401,39 +1355,38 @@ union cvmx_usbcx_ghwcfg4
                                                          * 2'b01: 16 bits
                                                          * 2'b10: 8/16 bits, software selectable
                                                          * Others: Reserved */
-	uint32_t reserved_6_13                : 8;
-	uint32_t ahbfreq                      : 1;  /**< Minimum AHB Frequency Less Than 60 MHz (AhbFreq)
+		uint32_t reserved_6_13:8;
+		uint32_t ahbfreq:1;		    /**< Minimum AHB Frequency Less Than 60 MHz (AhbFreq)
                                                          * 1'b0: No
                                                          * 1'b1: Yes */
-	uint32_t enablepwropt                 : 1;  /**< Enable Power Optimization? (EnablePwrOpt)
+		uint32_t enablepwropt:1;	    /**< Enable Power Optimization? (EnablePwrOpt)
                                                          * 1'b0: No
                                                          * 1'b1: Yes */
-	uint32_t numdevperioeps               : 4;  /**< Number of Device Mode Periodic IN Endpoints
+		uint32_t numdevperioeps:4;	    /**< Number of Device Mode Periodic IN Endpoints
                                                          (NumDevPerioEps)
                                                          Range: 0-15 */
 	} s;
-	struct cvmx_usbcx_ghwcfg4_cn30xx
-	{
-	uint32_t reserved_25_31               : 7;
-	uint32_t sessendfltr                  : 1;  /**< "session_end" Filter Enabled (SessEndFltr)
+	struct cvmx_usbcx_ghwcfg4_cn30xx {
+		uint32_t reserved_25_31:7;
+		uint32_t sessendfltr:1;		    /**< "session_end" Filter Enabled (SessEndFltr)
                                                          * 1'b0: No filter
                                                          * 1'b1: Filter */
-	uint32_t bvalidfltr                   : 1;  /**< "b_valid" Filter Enabled (BValidFltr)
+		uint32_t bvalidfltr:1;		    /**< "b_valid" Filter Enabled (BValidFltr)
                                                          * 1'b0: No filter
                                                          * 1'b1: Filter */
-	uint32_t avalidfltr                   : 1;  /**< "a_valid" Filter Enabled (AValidFltr)
+		uint32_t avalidfltr:1;		    /**< "a_valid" Filter Enabled (AValidFltr)
                                                          * 1'b0: No filter
                                                          * 1'b1: Filter */
-	uint32_t vbusvalidfltr                : 1;  /**< "vbus_valid" Filter Enabled (VBusValidFltr)
+		uint32_t vbusvalidfltr:1;	    /**< "vbus_valid" Filter Enabled (VBusValidFltr)
                                                          * 1'b0: No filter
                                                          * 1'b1: Filter */
-	uint32_t iddgfltr                     : 1;  /**< "iddig" Filter Enable (IddgFltr)
+		uint32_t iddgfltr:1;		    /**< "iddig" Filter Enable (IddgFltr)
                                                          * 1'b0: No filter
                                                          * 1'b1: Filter */
-	uint32_t numctleps                    : 4;  /**< Number of Device Mode Control Endpoints in Addition to
+		uint32_t numctleps:4;		    /**< Number of Device Mode Control Endpoints in Addition to
                                                          Endpoint 0 (NumCtlEps)
                                                          Range: 1-15 */
-	uint32_t phydatawidth                 : 2;  /**< UTMI+ PHY/ULPI-to-Internal UTMI+ Wrapper Data Width
+		uint32_t phydatawidth:2;	    /**< UTMI+ PHY/ULPI-to-Internal UTMI+ Wrapper Data Width
                                                          (PhyDataWidth)
                                                          When a ULPI PHY is used, an internal wrapper converts ULPI
                                                          to UTMI+.
@@ -1441,23 +1394,23 @@ union cvmx_usbcx_ghwcfg4
                                                          * 2'b01: 16 bits
                                                          * 2'b10: 8/16 bits, software selectable
                                                          * Others: Reserved */
-	uint32_t reserved_6_13                : 8;
-	uint32_t ahbfreq                      : 1;  /**< Minimum AHB Frequency Less Than 60 MHz (AhbFreq)
+		uint32_t reserved_6_13:8;
+		uint32_t ahbfreq:1;		    /**< Minimum AHB Frequency Less Than 60 MHz (AhbFreq)
                                                          * 1'b0: No
                                                          * 1'b1: Yes */
-	uint32_t enablepwropt                 : 1;  /**< Enable Power Optimization? (EnablePwrOpt)
+		uint32_t enablepwropt:1;	    /**< Enable Power Optimization? (EnablePwrOpt)
                                                          * 1'b0: No
                                                          * 1'b1: Yes */
-	uint32_t numdevperioeps               : 4;  /**< Number of Device Mode Periodic IN Endpoints
+		uint32_t numdevperioeps:4;	    /**< Number of Device Mode Periodic IN Endpoints
                                                          (NumDevPerioEps)
                                                          Range: 0-15 */
 	} cn30xx;
-	struct cvmx_usbcx_ghwcfg4_cn30xx      cn31xx;
-	struct cvmx_usbcx_ghwcfg4_s           cn50xx;
-	struct cvmx_usbcx_ghwcfg4_s           cn52xx;
-	struct cvmx_usbcx_ghwcfg4_s           cn52xxp1;
-	struct cvmx_usbcx_ghwcfg4_s           cn56xx;
-	struct cvmx_usbcx_ghwcfg4_s           cn56xxp1;
+	struct cvmx_usbcx_ghwcfg4_cn30xx cn31xx;
+	struct cvmx_usbcx_ghwcfg4_s cn50xx;
+	struct cvmx_usbcx_ghwcfg4_s cn52xx;
+	struct cvmx_usbcx_ghwcfg4_s cn52xxp1;
+	struct cvmx_usbcx_ghwcfg4_s cn56xx;
+	struct cvmx_usbcx_ghwcfg4_s cn56xxp1;
 };
 typedef union cvmx_usbcx_ghwcfg4 cvmx_usbcx_ghwcfg4_t;
 
@@ -1471,57 +1424,55 @@ typedef union cvmx_usbcx_ghwcfg4 cvmx_usbcx_ghwcfg4_t;
  * However, the Core Interrupt (GINTSTS) register bit corresponding to that interrupt will still be set.
  * Mask interrupt: 1'b0, Unmask interrupt: 1'b1
  */
-union cvmx_usbcx_gintmsk
-{
+union cvmx_usbcx_gintmsk {
 	uint32_t u32;
-	struct cvmx_usbcx_gintmsk_s
-	{
-	uint32_t wkupintmsk                   : 1;  /**< Resume/Remote Wakeup Detected Interrupt Mask
+	struct cvmx_usbcx_gintmsk_s {
+		uint32_t wkupintmsk:1;		    /**< Resume/Remote Wakeup Detected Interrupt Mask
                                                          (WkUpIntMsk) */
-	uint32_t sessreqintmsk                : 1;  /**< Session Request/New Session Detected Interrupt Mask
+		uint32_t sessreqintmsk:1;	    /**< Session Request/New Session Detected Interrupt Mask
                                                          (SessReqIntMsk) */
-	uint32_t disconnintmsk                : 1;  /**< Disconnect Detected Interrupt Mask (DisconnIntMsk) */
-	uint32_t conidstschngmsk              : 1;  /**< Connector ID Status Change Mask (ConIDStsChngMsk) */
-	uint32_t reserved_27_27               : 1;
-	uint32_t ptxfempmsk                   : 1;  /**< Periodic TxFIFO Empty Mask (PTxFEmpMsk) */
-	uint32_t hchintmsk                    : 1;  /**< Host Channels Interrupt Mask (HChIntMsk) */
-	uint32_t prtintmsk                    : 1;  /**< Host Port Interrupt Mask (PrtIntMsk) */
-	uint32_t reserved_23_23               : 1;
-	uint32_t fetsuspmsk                   : 1;  /**< Data Fetch Suspended Mask (FetSuspMsk) */
-	uint32_t incomplpmsk                  : 1;  /**< Incomplete Periodic Transfer Mask (incomplPMsk)
+		uint32_t disconnintmsk:1;	    /**< Disconnect Detected Interrupt Mask (DisconnIntMsk) */
+		uint32_t conidstschngmsk:1;	    /**< Connector ID Status Change Mask (ConIDStsChngMsk) */
+		uint32_t reserved_27_27:1;
+		uint32_t ptxfempmsk:1;		    /**< Periodic TxFIFO Empty Mask (PTxFEmpMsk) */
+		uint32_t hchintmsk:1;		    /**< Host Channels Interrupt Mask (HChIntMsk) */
+		uint32_t prtintmsk:1;		    /**< Host Port Interrupt Mask (PrtIntMsk) */
+		uint32_t reserved_23_23:1;
+		uint32_t fetsuspmsk:1;		    /**< Data Fetch Suspended Mask (FetSuspMsk) */
+		uint32_t incomplpmsk:1;		    /**< Incomplete Periodic Transfer Mask (incomplPMsk)
                                                          Incomplete Isochronous OUT Transfer Mask
                                                          (incompISOOUTMsk) */
-	uint32_t incompisoinmsk               : 1;  /**< Incomplete Isochronous IN Transfer Mask (incompISOINMsk) */
-	uint32_t oepintmsk                    : 1;  /**< OUT Endpoints Interrupt Mask (OEPIntMsk) */
-	uint32_t inepintmsk                   : 1;  /**< IN Endpoints Interrupt Mask (INEPIntMsk) */
-	uint32_t epmismsk                     : 1;  /**< Endpoint Mismatch Interrupt Mask (EPMisMsk) */
-	uint32_t reserved_16_16               : 1;
-	uint32_t eopfmsk                      : 1;  /**< End of Periodic Frame Interrupt Mask (EOPFMsk) */
-	uint32_t isooutdropmsk                : 1;  /**< Isochronous OUT Packet Dropped Interrupt Mask
+		uint32_t incompisoinmsk:1;	    /**< Incomplete Isochronous IN Transfer Mask (incompISOINMsk) */
+		uint32_t oepintmsk:1;		    /**< OUT Endpoints Interrupt Mask (OEPIntMsk) */
+		uint32_t inepintmsk:1;		    /**< IN Endpoints Interrupt Mask (INEPIntMsk) */
+		uint32_t epmismsk:1;		    /**< Endpoint Mismatch Interrupt Mask (EPMisMsk) */
+		uint32_t reserved_16_16:1;
+		uint32_t eopfmsk:1;		    /**< End of Periodic Frame Interrupt Mask (EOPFMsk) */
+		uint32_t isooutdropmsk:1;	    /**< Isochronous OUT Packet Dropped Interrupt Mask
                                                          (ISOOutDropMsk) */
-	uint32_t enumdonemsk                  : 1;  /**< Enumeration Done Mask (EnumDoneMsk) */
-	uint32_t usbrstmsk                    : 1;  /**< USB Reset Mask (USBRstMsk) */
-	uint32_t usbsuspmsk                   : 1;  /**< USB Suspend Mask (USBSuspMsk) */
-	uint32_t erlysuspmsk                  : 1;  /**< Early Suspend Mask (ErlySuspMsk) */
-	uint32_t i2cint                       : 1;  /**< I2C Interrupt Mask (I2CINT) */
-	uint32_t ulpickintmsk                 : 1;  /**< ULPI Carkit Interrupt Mask (ULPICKINTMsk)
+		uint32_t enumdonemsk:1;		    /**< Enumeration Done Mask (EnumDoneMsk) */
+		uint32_t usbrstmsk:1;		    /**< USB Reset Mask (USBRstMsk) */
+		uint32_t usbsuspmsk:1;		    /**< USB Suspend Mask (USBSuspMsk) */
+		uint32_t erlysuspmsk:1;		    /**< Early Suspend Mask (ErlySuspMsk) */
+		uint32_t i2cint:1;		    /**< I2C Interrupt Mask (I2CINT) */
+		uint32_t ulpickintmsk:1;	    /**< ULPI Carkit Interrupt Mask (ULPICKINTMsk)
                                                          I2C Carkit Interrupt Mask (I2CCKINTMsk) */
-	uint32_t goutnakeffmsk                : 1;  /**< Global OUT NAK Effective Mask (GOUTNakEffMsk) */
-	uint32_t ginnakeffmsk                 : 1;  /**< Global Non-Periodic IN NAK Effective Mask (GINNakEffMsk) */
-	uint32_t nptxfempmsk                  : 1;  /**< Non-Periodic TxFIFO Empty Mask (NPTxFEmpMsk) */
-	uint32_t rxflvlmsk                    : 1;  /**< Receive FIFO Non-Empty Mask (RxFLvlMsk) */
-	uint32_t sofmsk                       : 1;  /**< Start of (micro)Frame Mask (SofMsk) */
-	uint32_t otgintmsk                    : 1;  /**< OTG Interrupt Mask (OTGIntMsk) */
-	uint32_t modemismsk                   : 1;  /**< Mode Mismatch Interrupt Mask (ModeMisMsk) */
-	uint32_t reserved_0_0                 : 1;
+		uint32_t goutnakeffmsk:1;	    /**< Global OUT NAK Effective Mask (GOUTNakEffMsk) */
+		uint32_t ginnakeffmsk:1;	    /**< Global Non-Periodic IN NAK Effective Mask (GINNakEffMsk) */
+		uint32_t nptxfempmsk:1;		    /**< Non-Periodic TxFIFO Empty Mask (NPTxFEmpMsk) */
+		uint32_t rxflvlmsk:1;		    /**< Receive FIFO Non-Empty Mask (RxFLvlMsk) */
+		uint32_t sofmsk:1;		    /**< Start of (micro)Frame Mask (SofMsk) */
+		uint32_t otgintmsk:1;		    /**< OTG Interrupt Mask (OTGIntMsk) */
+		uint32_t modemismsk:1;		    /**< Mode Mismatch Interrupt Mask (ModeMisMsk) */
+		uint32_t reserved_0_0:1;
 	} s;
-	struct cvmx_usbcx_gintmsk_s           cn30xx;
-	struct cvmx_usbcx_gintmsk_s           cn31xx;
-	struct cvmx_usbcx_gintmsk_s           cn50xx;
-	struct cvmx_usbcx_gintmsk_s           cn52xx;
-	struct cvmx_usbcx_gintmsk_s           cn52xxp1;
-	struct cvmx_usbcx_gintmsk_s           cn56xx;
-	struct cvmx_usbcx_gintmsk_s           cn56xxp1;
+	struct cvmx_usbcx_gintmsk_s cn30xx;
+	struct cvmx_usbcx_gintmsk_s cn31xx;
+	struct cvmx_usbcx_gintmsk_s cn50xx;
+	struct cvmx_usbcx_gintmsk_s cn52xx;
+	struct cvmx_usbcx_gintmsk_s cn52xxp1;
+	struct cvmx_usbcx_gintmsk_s cn56xx;
+	struct cvmx_usbcx_gintmsk_s cn56xxp1;
 };
 typedef union cvmx_usbcx_gintmsk cvmx_usbcx_gintmsk_t;
 
@@ -1537,39 +1488,37 @@ typedef union cvmx_usbcx_gintmsk cvmx_usbcx_gintmsk_t;
  * The FIFO status interrupts are read only; once software reads from or writes to the FIFO while servicing these
  * interrupts, FIFO interrupt conditions are cleared automatically.
  */
-union cvmx_usbcx_gintsts
-{
+union cvmx_usbcx_gintsts {
 	uint32_t u32;
-	struct cvmx_usbcx_gintsts_s
-	{
-	uint32_t wkupint                      : 1;  /**< Resume/Remote Wakeup Detected Interrupt (WkUpInt)
+	struct cvmx_usbcx_gintsts_s {
+		uint32_t wkupint:1;		    /**< Resume/Remote Wakeup Detected Interrupt (WkUpInt)
                                                          In Device mode, this interrupt is asserted when a resume is
                                                          detected on the USB. In Host mode, this interrupt is asserted
                                                          when a remote wakeup is detected on the USB.
                                                          For more information on how to use this interrupt, see "Partial
                                                          Power-Down and Clock Gating Programming Model" on
                                                          page 353. */
-	uint32_t sessreqint                   : 1;  /**< Session Request/New Session Detected Interrupt (SessReqInt)
+		uint32_t sessreqint:1;		    /**< Session Request/New Session Detected Interrupt (SessReqInt)
                                                          In Host mode, this interrupt is asserted when a session request
                                                          is detected from the device. In Device mode, this interrupt is
                                                          asserted when the utmiotg_bvalid signal goes high.
                                                          For more information on how to use this interrupt, see "Partial
                                                          Power-Down and Clock Gating Programming Model" on
                                                          page 353. */
-	uint32_t disconnint                   : 1;  /**< Disconnect Detected Interrupt (DisconnInt)
+		uint32_t disconnint:1;		    /**< Disconnect Detected Interrupt (DisconnInt)
                                                          Asserted when a device disconnect is detected. */
-	uint32_t conidstschng                 : 1;  /**< Connector ID Status Change (ConIDStsChng)
+		uint32_t conidstschng:1;	    /**< Connector ID Status Change (ConIDStsChng)
                                                          The core sets this bit when there is a change in connector ID
                                                          status. */
-	uint32_t reserved_27_27               : 1;
-	uint32_t ptxfemp                      : 1;  /**< Periodic TxFIFO Empty (PTxFEmp)
+		uint32_t reserved_27_27:1;
+		uint32_t ptxfemp:1;		    /**< Periodic TxFIFO Empty (PTxFEmp)
                                                          Asserted when the Periodic Transmit FIFO is either half or
                                                          completely empty and there is space for at least one entry to be
                                                          written in the Periodic Request Queue. The half or completely
                                                          empty status is determined by the Periodic TxFIFO Empty Level
                                                          bit in the Core AHB Configuration register
                                                          (GAHBCFG.PTxFEmpLvl). */
-	uint32_t hchint                       : 1;  /**< Host Channels Interrupt (HChInt)
+		uint32_t hchint:1;		    /**< Host Channels Interrupt (HChInt)
                                                          The core sets this bit to indicate that an interrupt is pending on
                                                          one of the channels of the core (in Host mode). The application
                                                          must read the Host All Channels Interrupt (HAINT) register to
@@ -1578,21 +1527,21 @@ union cvmx_usbcx_gintsts
                                                          Channel-n Interrupt (HCINTn) register to determine the exact
                                                          cause of the interrupt. The application must clear the
                                                          appropriate status bit in the HCINTn register to clear this bit. */
-	uint32_t prtint                       : 1;  /**< Host Port Interrupt (PrtInt)
+		uint32_t prtint:1;		    /**< Host Port Interrupt (PrtInt)
                                                          The core sets this bit to indicate a change in port status of one
                                                          of the O2P USB core ports in Host mode. The application must
                                                          read the Host Port Control and Status (HPRT) register to
                                                          determine the exact event that caused this interrupt. The
                                                          application must clear the appropriate status bit in the Host Port
                                                          Control and Status register to clear this bit. */
-	uint32_t reserved_23_23               : 1;
-	uint32_t fetsusp                      : 1;  /**< Data Fetch Suspended (FetSusp)
+		uint32_t reserved_23_23:1;
+		uint32_t fetsusp:1;		    /**< Data Fetch Suspended (FetSusp)
                                                          This interrupt is valid only in DMA mode. This interrupt indicates
                                                          that the core has stopped fetching data for IN endpoints due to
                                                          the unavailability of TxFIFO space or Request Queue space.
                                                          This interrupt is used by the application for an endpoint
                                                          mismatch algorithm. */
-	uint32_t incomplp                     : 1;  /**< Incomplete Periodic Transfer (incomplP)
+		uint32_t incomplp:1;		    /**< Incomplete Periodic Transfer (incomplP)
                                                          In Host mode, the core sets this interrupt bit when there are
                                                          incomplete periodic transactions still pending which are
                                                          scheduled for the current microframe.
@@ -1602,12 +1551,12 @@ union cvmx_usbcx_gintsts
                                                          transfer is not completed in the current microframe. This
                                                          interrupt is asserted along with the End of Periodic Frame
                                                          Interrupt (EOPF) bit in this register. */
-	uint32_t incompisoin                  : 1;  /**< Incomplete Isochronous IN Transfer (incompISOIN)
+		uint32_t incompisoin:1;		    /**< Incomplete Isochronous IN Transfer (incompISOIN)
                                                          The core sets this interrupt to indicate that there is at least one
                                                          isochronous IN endpoint on which the transfer is not completed
                                                          in the current microframe. This interrupt is asserted along with
                                                          the End of Periodic Frame Interrupt (EOPF) bit in this register. */
-	uint32_t oepint                       : 1;  /**< OUT Endpoints Interrupt (OEPInt)
+		uint32_t oepint:1;		    /**< OUT Endpoints Interrupt (OEPInt)
                                                          The core sets this bit to indicate that an interrupt is pending on
                                                          one of the OUT endpoints of the core (in Device mode). The
                                                          application must read the Device All Endpoints Interrupt
@@ -1617,7 +1566,7 @@ union cvmx_usbcx_gintsts
                                                          register to determine the exact cause of the interrupt. The
                                                          application must clear the appropriate status bit in the
                                                          corresponding DOEPINTn register to clear this bit. */
-	uint32_t iepint                       : 1;  /**< IN Endpoints Interrupt (IEPInt)
+		uint32_t iepint:1;		    /**< IN Endpoints Interrupt (IEPInt)
                                                          The core sets this bit to indicate that an interrupt is pending on
                                                          one of the IN endpoints of the core (in Device mode). The
                                                          application must read the Device All Endpoints Interrupt
@@ -1627,47 +1576,47 @@ union cvmx_usbcx_gintsts
                                                          register to determine the exact cause of the interrupt. The
                                                          application must clear the appropriate status bit in the
                                                          corresponding DIEPINTn register to clear this bit. */
-	uint32_t epmis                        : 1;  /**< Endpoint Mismatch Interrupt (EPMis)
+		uint32_t epmis:1;		    /**< Endpoint Mismatch Interrupt (EPMis)
                                                          Indicates that an IN token has been received for a non-periodic
                                                          endpoint, but the data for another endpoint is present in the top
                                                          of the Non-Periodic Transmit FIFO and the IN endpoint
                                                          mismatch count programmed by the application has expired. */
-	uint32_t reserved_16_16               : 1;
-	uint32_t eopf                         : 1;  /**< End of Periodic Frame Interrupt (EOPF)
+		uint32_t reserved_16_16:1;
+		uint32_t eopf:1;		    /**< End of Periodic Frame Interrupt (EOPF)
                                                          Indicates that the period specified in the Periodic Frame Interval
                                                          field of the Device Configuration register (DCFG.PerFrInt) has
                                                          been reached in the current microframe. */
-	uint32_t isooutdrop                   : 1;  /**< Isochronous OUT Packet Dropped Interrupt (ISOOutDrop)
+		uint32_t isooutdrop:1;		    /**< Isochronous OUT Packet Dropped Interrupt (ISOOutDrop)
                                                          The core sets this bit when it fails to write an isochronous OUT
                                                          packet into the RxFIFO because the RxFIFO doesn't have
                                                          enough space to accommodate a maximum packet size packet
                                                          for the isochronous OUT endpoint. */
-	uint32_t enumdone                     : 1;  /**< Enumeration Done (EnumDone)
+		uint32_t enumdone:1;		    /**< Enumeration Done (EnumDone)
                                                          The core sets this bit to indicate that speed enumeration is
                                                          complete. The application must read the Device Status (DSTS)
                                                          register to obtain the enumerated speed. */
-	uint32_t usbrst                       : 1;  /**< USB Reset (USBRst)
+		uint32_t usbrst:1;		    /**< USB Reset (USBRst)
                                                          The core sets this bit to indicate that a reset is detected on the
                                                          USB. */
-	uint32_t usbsusp                      : 1;  /**< USB Suspend (USBSusp)
+		uint32_t usbsusp:1;		    /**< USB Suspend (USBSusp)
                                                          The core sets this bit to indicate that a suspend was detected
                                                          on the USB. The core enters the Suspended state when there
                                                          is no activity on the phy_line_state_i signal for an extended
                                                          period of time. */
-	uint32_t erlysusp                     : 1;  /**< Early Suspend (ErlySusp)
+		uint32_t erlysusp:1;		    /**< Early Suspend (ErlySusp)
                                                          The core sets this bit to indicate that an Idle state has been
                                                          detected on the USB for 3 ms. */
-	uint32_t i2cint                       : 1;  /**< I2C Interrupt (I2CINT)
+		uint32_t i2cint:1;		    /**< I2C Interrupt (I2CINT)
                                                          This bit is always 0x0. */
-	uint32_t ulpickint                    : 1;  /**< ULPI Carkit Interrupt (ULPICKINT)
+		uint32_t ulpickint:1;		    /**< ULPI Carkit Interrupt (ULPICKINT)
                                                          This bit is always 0x0. */
-	uint32_t goutnakeff                   : 1;  /**< Global OUT NAK Effective (GOUTNakEff)
+		uint32_t goutnakeff:1;		    /**< Global OUT NAK Effective (GOUTNakEff)
                                                          Indicates that the Set Global OUT NAK bit in the Device Control
                                                          register (DCTL.SGOUTNak), set by the application, has taken
                                                          effect in the core. This bit can be cleared by writing the Clear
                                                          Global OUT NAK bit in the Device Control register
                                                          (DCTL.CGOUTNak). */
-	uint32_t ginnakeff                    : 1;  /**< Global IN Non-Periodic NAK Effective (GINNakEff)
+		uint32_t ginnakeff:1;		    /**< Global IN Non-Periodic NAK Effective (GINNakEff)
                                                          Indicates that the Set Global Non-Periodic IN NAK bit in the
                                                          Device Control register (DCTL.SGNPInNak), set by the
                                                          application, has taken effect in the core. That is, the core has
@@ -1677,17 +1626,17 @@ union cvmx_usbcx_gintsts
                                                          This interrupt does not necessarily mean that a NAK handshake
                                                          is sent out on the USB. The STALL bit takes precedence over
                                                          the NAK bit. */
-	uint32_t nptxfemp                     : 1;  /**< Non-Periodic TxFIFO Empty (NPTxFEmp)
+		uint32_t nptxfemp:1;		    /**< Non-Periodic TxFIFO Empty (NPTxFEmp)
                                                          This interrupt is asserted when the Non-Periodic TxFIFO is
                                                          either half or completely empty, and there is space for at least
                                                          one entry to be written to the Non-Periodic Transmit Request
                                                          Queue. The half or completely empty status is determined by
                                                          the Non-Periodic TxFIFO Empty Level bit in the Core AHB
                                                          Configuration register (GAHBCFG.NPTxFEmpLvl). */
-	uint32_t rxflvl                       : 1;  /**< RxFIFO Non-Empty (RxFLvl)
+		uint32_t rxflvl:1;		    /**< RxFIFO Non-Empty (RxFLvl)
                                                          Indicates that there is at least one packet pending to be read
                                                          from the RxFIFO. */
-	uint32_t sof                          : 1;  /**< Start of (micro)Frame (Sof)
+		uint32_t sof:1;			    /**< Start of (micro)Frame (Sof)
                                                          In Host mode, the core sets this bit to indicate that an SOF
                                                          (FS), micro-SOF (HS), or Keep-Alive (LS) is transmitted on the
                                                          USB. The application must write a 1 to this bit to clear the
@@ -1697,13 +1646,13 @@ union cvmx_usbcx_gintsts
                                                          the Device Status register to get the current (micro)frame
                                                          number. This interrupt is seen only when the core is operating
                                                          at either HS or FS. */
-	uint32_t otgint                       : 1;  /**< OTG Interrupt (OTGInt)
+		uint32_t otgint:1;		    /**< OTG Interrupt (OTGInt)
                                                          The core sets this bit to indicate an OTG protocol event. The
                                                          application must read the OTG Interrupt Status (GOTGINT)
                                                          register to determine the exact event that caused this interrupt.
                                                          The application must clear the appropriate status bit in the
                                                          GOTGINT register to clear this bit. */
-	uint32_t modemis                      : 1;  /**< Mode Mismatch Interrupt (ModeMis)
+		uint32_t modemis:1;		    /**< Mode Mismatch Interrupt (ModeMis)
                                                          The core sets this bit when the application is trying to access:
                                                          * A Host mode register, when the core is operating in Device
                                                          mode
@@ -1712,18 +1661,18 @@ union cvmx_usbcx_gintsts
                                                            The register access is completed on the AHB with an OKAY
                                                            response, but is ignored by the core internally and doesn't
                                                          affect the operation of the core. */
-	uint32_t curmod                       : 1;  /**< Current Mode of Operation (CurMod)
+		uint32_t curmod:1;		    /**< Current Mode of Operation (CurMod)
                                                          Indicates the current mode of operation.
                                                          * 1'b0: Device mode
                                                          * 1'b1: Host mode */
 	} s;
-	struct cvmx_usbcx_gintsts_s           cn30xx;
-	struct cvmx_usbcx_gintsts_s           cn31xx;
-	struct cvmx_usbcx_gintsts_s           cn50xx;
-	struct cvmx_usbcx_gintsts_s           cn52xx;
-	struct cvmx_usbcx_gintsts_s           cn52xxp1;
-	struct cvmx_usbcx_gintsts_s           cn56xx;
-	struct cvmx_usbcx_gintsts_s           cn56xxp1;
+	struct cvmx_usbcx_gintsts_s cn30xx;
+	struct cvmx_usbcx_gintsts_s cn31xx;
+	struct cvmx_usbcx_gintsts_s cn50xx;
+	struct cvmx_usbcx_gintsts_s cn52xx;
+	struct cvmx_usbcx_gintsts_s cn52xxp1;
+	struct cvmx_usbcx_gintsts_s cn56xx;
+	struct cvmx_usbcx_gintsts_s cn56xxp1;
 };
 typedef union cvmx_usbcx_gintsts cvmx_usbcx_gintsts_t;
 
@@ -1734,26 +1683,24 @@ typedef union cvmx_usbcx_gintsts cvmx_usbcx_gintsts_t;
  *
  * The application can program the RAM size and the memory start address for the Non-Periodic TxFIFO.
  */
-union cvmx_usbcx_gnptxfsiz
-{
+union cvmx_usbcx_gnptxfsiz {
 	uint32_t u32;
-	struct cvmx_usbcx_gnptxfsiz_s
-	{
-	uint32_t nptxfdep                     : 16; /**< Non-Periodic TxFIFO Depth (NPTxFDep)
+	struct cvmx_usbcx_gnptxfsiz_s {
+		uint32_t nptxfdep:16;		    /**< Non-Periodic TxFIFO Depth (NPTxFDep)
                                                          This value is in terms of 32-bit words.
                                                          Minimum value is 16
                                                          Maximum value is 32768 */
-	uint32_t nptxfstaddr                  : 16; /**< Non-Periodic Transmit RAM Start Address (NPTxFStAddr)
+		uint32_t nptxfstaddr:16;	    /**< Non-Periodic Transmit RAM Start Address (NPTxFStAddr)
                                                          This field contains the memory start address for Non-Periodic
                                                          Transmit FIFO RAM. */
 	} s;
-	struct cvmx_usbcx_gnptxfsiz_s         cn30xx;
-	struct cvmx_usbcx_gnptxfsiz_s         cn31xx;
-	struct cvmx_usbcx_gnptxfsiz_s         cn50xx;
-	struct cvmx_usbcx_gnptxfsiz_s         cn52xx;
-	struct cvmx_usbcx_gnptxfsiz_s         cn52xxp1;
-	struct cvmx_usbcx_gnptxfsiz_s         cn56xx;
-	struct cvmx_usbcx_gnptxfsiz_s         cn56xxp1;
+	struct cvmx_usbcx_gnptxfsiz_s cn30xx;
+	struct cvmx_usbcx_gnptxfsiz_s cn31xx;
+	struct cvmx_usbcx_gnptxfsiz_s cn50xx;
+	struct cvmx_usbcx_gnptxfsiz_s cn52xx;
+	struct cvmx_usbcx_gnptxfsiz_s cn52xxp1;
+	struct cvmx_usbcx_gnptxfsiz_s cn56xx;
+	struct cvmx_usbcx_gnptxfsiz_s cn56xxp1;
 };
 typedef union cvmx_usbcx_gnptxfsiz cvmx_usbcx_gnptxfsiz_t;
 
@@ -1765,13 +1712,11 @@ typedef union cvmx_usbcx_gnptxfsiz cvmx_usbcx_gnptxfsiz_t;
  * This read-only register contains the free space information for the Non-Periodic TxFIFO and
  * the Non-Periodic Transmit Request Queue
  */
-union cvmx_usbcx_gnptxsts
-{
+union cvmx_usbcx_gnptxsts {
 	uint32_t u32;
-	struct cvmx_usbcx_gnptxsts_s
-	{
-	uint32_t reserved_31_31               : 1;
-	uint32_t nptxqtop                     : 7;  /**< Top of the Non-Periodic Transmit Request Queue (NPTxQTop)
+	struct cvmx_usbcx_gnptxsts_s {
+		uint32_t reserved_31_31:1;
+		uint32_t nptxqtop:7;		    /**< Top of the Non-Periodic Transmit Request Queue (NPTxQTop)
                                                          Entry in the Non-Periodic Tx Request Queue that is currently
                                                          being processed by the MAC.
                                                          * Bits [30:27]: Channel/endpoint number
@@ -1781,7 +1726,7 @@ union cvmx_usbcx_gnptxsts
                                                            - 2'b10: PING/CSPLIT token
                                                            - 2'b11: Channel halt command
                                                          * Bit [24]: Terminate (last entry for selected channel/endpoint) */
-	uint32_t nptxqspcavail                : 8;  /**< Non-Periodic Transmit Request Queue Space Available
+		uint32_t nptxqspcavail:8;	    /**< Non-Periodic Transmit Request Queue Space Available
                                                          (NPTxQSpcAvail)
                                                          Indicates the amount of free space available in the Non-
                                                          Periodic Transmit Request Queue. This queue holds both IN
@@ -1792,7 +1737,7 @@ union cvmx_usbcx_gnptxsts
                                                          * 8'h2: 2 locations available
                                                          * n: n locations available (0..8)
                                                          * Others: Reserved */
-	uint32_t nptxfspcavail                : 16; /**< Non-Periodic TxFIFO Space Avail (NPTxFSpcAvail)
+		uint32_t nptxfspcavail:16;	    /**< Non-Periodic TxFIFO Space Avail (NPTxFSpcAvail)
                                                          Indicates the amount of free space available in the Non-
                                                          Periodic TxFIFO.
                                                          Values are in terms of 32-bit words.
@@ -1803,13 +1748,13 @@ union cvmx_usbcx_gnptxsts
                                                          * 16'h8000: 32768 words available
                                                          * Others: Reserved */
 	} s;
-	struct cvmx_usbcx_gnptxsts_s          cn30xx;
-	struct cvmx_usbcx_gnptxsts_s          cn31xx;
-	struct cvmx_usbcx_gnptxsts_s          cn50xx;
-	struct cvmx_usbcx_gnptxsts_s          cn52xx;
-	struct cvmx_usbcx_gnptxsts_s          cn52xxp1;
-	struct cvmx_usbcx_gnptxsts_s          cn56xx;
-	struct cvmx_usbcx_gnptxsts_s          cn56xxp1;
+	struct cvmx_usbcx_gnptxsts_s cn30xx;
+	struct cvmx_usbcx_gnptxsts_s cn31xx;
+	struct cvmx_usbcx_gnptxsts_s cn50xx;
+	struct cvmx_usbcx_gnptxsts_s cn52xx;
+	struct cvmx_usbcx_gnptxsts_s cn52xxp1;
+	struct cvmx_usbcx_gnptxsts_s cn56xx;
+	struct cvmx_usbcx_gnptxsts_s cn56xxp1;
 };
 typedef union cvmx_usbcx_gnptxsts cvmx_usbcx_gnptxsts_t;
 
@@ -1820,50 +1765,48 @@ typedef union cvmx_usbcx_gnptxsts cvmx_usbcx_gnptxsts_t;
  *
  * The OTG Control and Status register controls the behavior and reflects the status of the OTG function of the core.:
  */
-union cvmx_usbcx_gotgctl
-{
+union cvmx_usbcx_gotgctl {
 	uint32_t u32;
-	struct cvmx_usbcx_gotgctl_s
-	{
-	uint32_t reserved_20_31               : 12;
-	uint32_t bsesvld                      : 1;  /**< B-Session Valid (BSesVld)
+	struct cvmx_usbcx_gotgctl_s {
+		uint32_t reserved_20_31:12;
+		uint32_t bsesvld:1;		    /**< B-Session Valid (BSesVld)
                                                          Valid only when O2P USB core is configured as a USB device.
                                                          Indicates the Device mode transceiver status.
                                                          * 1'b0: B-session is not valid.
                                                          * 1'b1: B-session is valid. */
-	uint32_t asesvld                      : 1;  /**< A-Session Valid (ASesVld)
+		uint32_t asesvld:1;		    /**< A-Session Valid (ASesVld)
                                                          Valid only when O2P USB core is configured as a USB host.
                                                          Indicates the Host mode transceiver status.
                                                          * 1'b0: A-session is not valid
                                                          * 1'b1: A-session is valid */
-	uint32_t dbnctime                     : 1;  /**< Long/Short Debounce Time (DbncTime)
+		uint32_t dbnctime:1;		    /**< Long/Short Debounce Time (DbncTime)
                                                          In the present version of the core this bit will only read as '0'. */
-	uint32_t conidsts                     : 1;  /**< Connector ID Status (ConIDSts)
+		uint32_t conidsts:1;		    /**< Connector ID Status (ConIDSts)
                                                          Indicates the connector ID status on a connect event.
                                                          * 1'b0: The O2P USB core is in A-device mode
                                                          * 1'b1: The O2P USB core is in B-device mode */
-	uint32_t reserved_12_15               : 4;
-	uint32_t devhnpen                     : 1;  /**< Device HNP Enabled (DevHNPEn)
+		uint32_t reserved_12_15:4;
+		uint32_t devhnpen:1;		    /**< Device HNP Enabled (DevHNPEn)
                                                          Since O2P USB core is not HNP capable this bit is 0x0. */
-	uint32_t hstsethnpen                  : 1;  /**< Host Set HNP Enable (HstSetHNPEn)
+		uint32_t hstsethnpen:1;		    /**< Host Set HNP Enable (HstSetHNPEn)
                                                          Since O2P USB core is not HNP capable this bit is 0x0. */
-	uint32_t hnpreq                       : 1;  /**< HNP Request (HNPReq)
+		uint32_t hnpreq:1;		    /**< HNP Request (HNPReq)
                                                          Since O2P USB core is not HNP capable this bit is 0x0. */
-	uint32_t hstnegscs                    : 1;  /**< Host Negotiation Success (HstNegScs)
+		uint32_t hstnegscs:1;		    /**< Host Negotiation Success (HstNegScs)
                                                          Since O2P USB core is not HNP capable this bit is 0x0. */
-	uint32_t reserved_2_7                 : 6;
-	uint32_t sesreq                       : 1;  /**< Session Request (SesReq)
+		uint32_t reserved_2_7:6;
+		uint32_t sesreq:1;		    /**< Session Request (SesReq)
                                                          Since O2P USB core is not SRP capable this bit is 0x0. */
-	uint32_t sesreqscs                    : 1;  /**< Session Request Success (SesReqScs)
+		uint32_t sesreqscs:1;		    /**< Session Request Success (SesReqScs)
                                                          Since O2P USB core is not SRP capable this bit is 0x0. */
 	} s;
-	struct cvmx_usbcx_gotgctl_s           cn30xx;
-	struct cvmx_usbcx_gotgctl_s           cn31xx;
-	struct cvmx_usbcx_gotgctl_s           cn50xx;
-	struct cvmx_usbcx_gotgctl_s           cn52xx;
-	struct cvmx_usbcx_gotgctl_s           cn52xxp1;
-	struct cvmx_usbcx_gotgctl_s           cn56xx;
-	struct cvmx_usbcx_gotgctl_s           cn56xxp1;
+	struct cvmx_usbcx_gotgctl_s cn30xx;
+	struct cvmx_usbcx_gotgctl_s cn31xx;
+	struct cvmx_usbcx_gotgctl_s cn50xx;
+	struct cvmx_usbcx_gotgctl_s cn52xx;
+	struct cvmx_usbcx_gotgctl_s cn52xxp1;
+	struct cvmx_usbcx_gotgctl_s cn56xx;
+	struct cvmx_usbcx_gotgctl_s cn56xxp1;
 };
 typedef union cvmx_usbcx_gotgctl cvmx_usbcx_gotgctl_t;
 
@@ -1875,35 +1818,33 @@ typedef union cvmx_usbcx_gotgctl cvmx_usbcx_gotgctl_t;
  * The application reads this register whenever there is an OTG interrupt and clears the bits in this register
  * to clear the OTG interrupt. It is shown in Interrupt .:
  */
-union cvmx_usbcx_gotgint
-{
+union cvmx_usbcx_gotgint {
 	uint32_t u32;
-	struct cvmx_usbcx_gotgint_s
-	{
-	uint32_t reserved_20_31               : 12;
-	uint32_t dbncedone                    : 1;  /**< Debounce Done (DbnceDone)
+	struct cvmx_usbcx_gotgint_s {
+		uint32_t reserved_20_31:12;
+		uint32_t dbncedone:1;		    /**< Debounce Done (DbnceDone)
                                                          In the present version of the code this bit is tied to '0'. */
-	uint32_t adevtoutchg                  : 1;  /**< A-Device Timeout Change (ADevTOUTChg)
+		uint32_t adevtoutchg:1;		    /**< A-Device Timeout Change (ADevTOUTChg)
                                                          Since O2P USB core is not HNP or SRP capable this bit is always 0x0. */
-	uint32_t hstnegdet                    : 1;  /**< Host Negotiation Detected (HstNegDet)
+		uint32_t hstnegdet:1;		    /**< Host Negotiation Detected (HstNegDet)
                                                          Since O2P USB core is not HNP or SRP capable this bit is always 0x0. */
-	uint32_t reserved_10_16               : 7;
-	uint32_t hstnegsucstschng             : 1;  /**< Host Negotiation Success Status Change (HstNegSucStsChng)
+		uint32_t reserved_10_16:7;
+		uint32_t hstnegsucstschng:1;	    /**< Host Negotiation Success Status Change (HstNegSucStsChng)
                                                          Since O2P USB core is not HNP or SRP capable this bit is always 0x0. */
-	uint32_t sesreqsucstschng             : 1;  /**< Session Request Success Status Change
+		uint32_t sesreqsucstschng:1;	    /**< Session Request Success Status Change
                                                          Since O2P USB core is not HNP or SRP capable this bit is always 0x0. */
-	uint32_t reserved_3_7                 : 5;
-	uint32_t sesenddet                    : 1;  /**< Session End Detected (SesEndDet)
+		uint32_t reserved_3_7:5;
+		uint32_t sesenddet:1;		    /**< Session End Detected (SesEndDet)
                                                          Since O2P USB core is not HNP or SRP capable this bit is always 0x0. */
-	uint32_t reserved_0_1                 : 2;
+		uint32_t reserved_0_1:2;
 	} s;
-	struct cvmx_usbcx_gotgint_s           cn30xx;
-	struct cvmx_usbcx_gotgint_s           cn31xx;
-	struct cvmx_usbcx_gotgint_s           cn50xx;
-	struct cvmx_usbcx_gotgint_s           cn52xx;
-	struct cvmx_usbcx_gotgint_s           cn52xxp1;
-	struct cvmx_usbcx_gotgint_s           cn56xx;
-	struct cvmx_usbcx_gotgint_s           cn56xxp1;
+	struct cvmx_usbcx_gotgint_s cn30xx;
+	struct cvmx_usbcx_gotgint_s cn31xx;
+	struct cvmx_usbcx_gotgint_s cn50xx;
+	struct cvmx_usbcx_gotgint_s cn52xx;
+	struct cvmx_usbcx_gotgint_s cn52xxp1;
+	struct cvmx_usbcx_gotgint_s cn56xx;
+	struct cvmx_usbcx_gotgint_s cn56xxp1;
 };
 typedef union cvmx_usbcx_gotgint cvmx_usbcx_gotgint_t;
 
@@ -1914,18 +1855,16 @@ typedef union cvmx_usbcx_gotgint cvmx_usbcx_gotgint_t;
  *
  * The application uses this register to reset various hardware features inside the core.
  */
-union cvmx_usbcx_grstctl
-{
+union cvmx_usbcx_grstctl {
 	uint32_t u32;
-	struct cvmx_usbcx_grstctl_s
-	{
-	uint32_t ahbidle                      : 1;  /**< AHB Master Idle (AHBIdle)
+	struct cvmx_usbcx_grstctl_s {
+		uint32_t ahbidle:1;		    /**< AHB Master Idle (AHBIdle)
                                                          Indicates that the AHB Master State Machine is in the IDLE
                                                          condition. */
-	uint32_t dmareq                       : 1;  /**< DMA Request Signal (DMAReq)
+		uint32_t dmareq:1;		    /**< DMA Request Signal (DMAReq)
                                                          Indicates that the DMA request is in progress. Used for debug. */
-	uint32_t reserved_11_29               : 19;
-	uint32_t txfnum                       : 5;  /**< TxFIFO Number (TxFNum)
+		uint32_t reserved_11_29:19;
+		uint32_t txfnum:5;		    /**< TxFIFO Number (TxFNum)
                                                          This is the FIFO number that must be flushed using the TxFIFO
                                                          Flush bit. This field must not be changed until the core clears
                                                          the TxFIFO Flush bit.
@@ -1937,7 +1876,7 @@ union cvmx_usbcx_grstctl
                                                          * 5'hF: Periodic TxFIFO 15 flush in Device mode
                                                          * 5'h10: Flush all the Periodic and Non-Periodic TxFIFOs in the
                                                          core */
-	uint32_t txfflsh                      : 1;  /**< TxFIFO Flush (TxFFlsh)
+		uint32_t txfflsh:1;		    /**< TxFIFO Flush (TxFFlsh)
                                                          This bit selectively flushes a single or all transmit FIFOs, but
                                                          cannot do so if the core is in the midst of a transaction.
                                                          The application must only write this bit after checking that the
@@ -1946,7 +1885,7 @@ union cvmx_usbcx_grstctl
                                                          The application must wait until the core clears this bit before
                                                          performing any operations. This bit takes 8 clocks (of phy_clk or
                                                          hclk, whichever is slower) to clear. */
-	uint32_t rxfflsh                      : 1;  /**< RxFIFO Flush (RxFFlsh)
+		uint32_t rxfflsh:1;		    /**< RxFIFO Flush (RxFFlsh)
                                                          The application can flush the entire RxFIFO using this bit, but
                                                          must first ensure that the core is not in the middle of a
                                                          transaction.
@@ -1956,15 +1895,15 @@ union cvmx_usbcx_grstctl
                                                          The application must wait until the bit is cleared before
                                                          performing any other operations. This bit will take 8 clocks
                                                          (slowest of PHY or AHB clock) to clear. */
-	uint32_t intknqflsh                   : 1;  /**< IN Token Sequence Learning Queue Flush (INTknQFlsh)
+		uint32_t intknqflsh:1;		    /**< IN Token Sequence Learning Queue Flush (INTknQFlsh)
                                                          The application writes this bit to flush the IN Token Sequence
                                                          Learning Queue. */
-	uint32_t frmcntrrst                   : 1;  /**< Host Frame Counter Reset (FrmCntrRst)
+		uint32_t frmcntrrst:1;		    /**< Host Frame Counter Reset (FrmCntrRst)
                                                          The application writes this bit to reset the (micro)frame number
                                                          counter inside the core. When the (micro)frame counter is reset,
                                                          the subsequent SOF sent out by the core will have a
                                                          (micro)frame number of 0. */
-	uint32_t hsftrst                      : 1;  /**< HClk Soft Reset (HSftRst)
+		uint32_t hsftrst:1;		    /**< HClk Soft Reset (HSftRst)
                                                          The application uses this bit to flush the control logic in the AHB
                                                          Clock domain. Only AHB Clock Domain pipelines are reset.
                                                          * FIFOs are not flushed with this bit.
@@ -1982,7 +1921,7 @@ union cvmx_usbcx_grstctl
                                                            This is a self-clearing bit that the core clears after all necessary
                                                            logic is reset in the core. This may take several clocks,
                                                            depending on the core's current state. */
-	uint32_t csftrst                      : 1;  /**< Core Soft Reset (CSftRst)
+		uint32_t csftrst:1;		    /**< Core Soft Reset (CSftRst)
                                                          Resets the hclk and phy_clock domains as follows:
                                                          * Clears the interrupts and all the CSR registers except the
                                                            following register bits:
@@ -2021,13 +1960,13 @@ union cvmx_usbcx_grstctl
                                                            selected and used in the PHY domain. Once a new clock is
                                                            selected, the PHY domain has to be reset for proper operation. */
 	} s;
-	struct cvmx_usbcx_grstctl_s           cn30xx;
-	struct cvmx_usbcx_grstctl_s           cn31xx;
-	struct cvmx_usbcx_grstctl_s           cn50xx;
-	struct cvmx_usbcx_grstctl_s           cn52xx;
-	struct cvmx_usbcx_grstctl_s           cn52xxp1;
-	struct cvmx_usbcx_grstctl_s           cn56xx;
-	struct cvmx_usbcx_grstctl_s           cn56xxp1;
+	struct cvmx_usbcx_grstctl_s cn30xx;
+	struct cvmx_usbcx_grstctl_s cn31xx;
+	struct cvmx_usbcx_grstctl_s cn50xx;
+	struct cvmx_usbcx_grstctl_s cn52xx;
+	struct cvmx_usbcx_grstctl_s cn52xxp1;
+	struct cvmx_usbcx_grstctl_s cn56xx;
+	struct cvmx_usbcx_grstctl_s cn56xxp1;
 };
 typedef union cvmx_usbcx_grstctl cvmx_usbcx_grstctl_t;
 
@@ -2038,24 +1977,22 @@ typedef union cvmx_usbcx_grstctl cvmx_usbcx_grstctl_t;
  *
  * The application can program the RAM size that must be allocated to the RxFIFO.
  */
-union cvmx_usbcx_grxfsiz
-{
+union cvmx_usbcx_grxfsiz {
 	uint32_t u32;
-	struct cvmx_usbcx_grxfsiz_s
-	{
-	uint32_t reserved_16_31               : 16;
-	uint32_t rxfdep                       : 16; /**< RxFIFO Depth (RxFDep)
+	struct cvmx_usbcx_grxfsiz_s {
+		uint32_t reserved_16_31:16;
+		uint32_t rxfdep:16;		    /**< RxFIFO Depth (RxFDep)
                                                          This value is in terms of 32-bit words.
                                                          * Minimum value is 16
                                                          * Maximum value is 32768 */
 	} s;
-	struct cvmx_usbcx_grxfsiz_s           cn30xx;
-	struct cvmx_usbcx_grxfsiz_s           cn31xx;
-	struct cvmx_usbcx_grxfsiz_s           cn50xx;
-	struct cvmx_usbcx_grxfsiz_s           cn52xx;
-	struct cvmx_usbcx_grxfsiz_s           cn52xxp1;
-	struct cvmx_usbcx_grxfsiz_s           cn56xx;
-	struct cvmx_usbcx_grxfsiz_s           cn56xxp1;
+	struct cvmx_usbcx_grxfsiz_s cn30xx;
+	struct cvmx_usbcx_grxfsiz_s cn31xx;
+	struct cvmx_usbcx_grxfsiz_s cn50xx;
+	struct cvmx_usbcx_grxfsiz_s cn52xx;
+	struct cvmx_usbcx_grxfsiz_s cn52xxp1;
+	struct cvmx_usbcx_grxfsiz_s cn56xx;
+	struct cvmx_usbcx_grxfsiz_s cn56xxp1;
 };
 typedef union cvmx_usbcx_grxfsiz cvmx_usbcx_grxfsiz_t;
 
@@ -2070,41 +2007,39 @@ typedef union cvmx_usbcx_grxfsiz cvmx_usbcx_grxfsiz_t;
  *       The offset difference shown in this document is for software clarity and is actually ignored by the
  *       hardware.
  */
-union cvmx_usbcx_grxstspd
-{
+union cvmx_usbcx_grxstspd {
 	uint32_t u32;
-	struct cvmx_usbcx_grxstspd_s
-	{
-	uint32_t reserved_25_31               : 7;
-	uint32_t fn                           : 4;  /**< Frame Number (FN)
+	struct cvmx_usbcx_grxstspd_s {
+		uint32_t reserved_25_31:7;
+		uint32_t fn:4;			    /**< Frame Number (FN)
                                                          This is the least significant 4 bits of the (micro)frame number in
                                                          which the packet is received on the USB.  This field is supported
                                                          only when the isochronous OUT endpoints are supported. */
-	uint32_t pktsts                       : 4;  /**< Packet Status (PktSts)
+		uint32_t pktsts:4;		    /**< Packet Status (PktSts)
                                                          Indicates the status of the received packet
                                                          * 4'b0001: Glogal OUT NAK (triggers an interrupt)
                                                          * 4'b0010: OUT data packet received
                                                          * 4'b0100: SETUP transaction completed (triggers an interrupt)
                                                          * 4'b0110: SETUP data packet received
                                                          * Others: Reserved */
-	uint32_t dpid                         : 2;  /**< Data PID (DPID)
+		uint32_t dpid:2;		    /**< Data PID (DPID)
                                                          * 2'b00: DATA0
                                                          * 2'b10: DATA1
                                                          * 2'b01: DATA2
                                                          * 2'b11: MDATA */
-	uint32_t bcnt                         : 11; /**< Byte Count (BCnt)
+		uint32_t bcnt:11;		    /**< Byte Count (BCnt)
                                                          Indicates the byte count of the received data packet */
-	uint32_t epnum                        : 4;  /**< Endpoint Number (EPNum)
+		uint32_t epnum:4;		    /**< Endpoint Number (EPNum)
                                                          Indicates the endpoint number to which the current received
                                                          packet belongs. */
 	} s;
-	struct cvmx_usbcx_grxstspd_s          cn30xx;
-	struct cvmx_usbcx_grxstspd_s          cn31xx;
-	struct cvmx_usbcx_grxstspd_s          cn50xx;
-	struct cvmx_usbcx_grxstspd_s          cn52xx;
-	struct cvmx_usbcx_grxstspd_s          cn52xxp1;
-	struct cvmx_usbcx_grxstspd_s          cn56xx;
-	struct cvmx_usbcx_grxstspd_s          cn56xxp1;
+	struct cvmx_usbcx_grxstspd_s cn30xx;
+	struct cvmx_usbcx_grxstspd_s cn31xx;
+	struct cvmx_usbcx_grxstspd_s cn50xx;
+	struct cvmx_usbcx_grxstspd_s cn52xx;
+	struct cvmx_usbcx_grxstspd_s cn52xxp1;
+	struct cvmx_usbcx_grxstspd_s cn56xx;
+	struct cvmx_usbcx_grxstspd_s cn56xxp1;
 };
 typedef union cvmx_usbcx_grxstspd cvmx_usbcx_grxstspd_t;
 
@@ -2119,37 +2054,35 @@ typedef union cvmx_usbcx_grxstspd cvmx_usbcx_grxstspd_t;
  *       The offset difference shown in this document is for software clarity and is actually ignored by the
  *       hardware.
  */
-union cvmx_usbcx_grxstsph
-{
+union cvmx_usbcx_grxstsph {
 	uint32_t u32;
-	struct cvmx_usbcx_grxstsph_s
-	{
-	uint32_t reserved_21_31               : 11;
-	uint32_t pktsts                       : 4;  /**< Packet Status (PktSts)
+	struct cvmx_usbcx_grxstsph_s {
+		uint32_t reserved_21_31:11;
+		uint32_t pktsts:4;		    /**< Packet Status (PktSts)
                                                          Indicates the status of the received packet
                                                          * 4'b0010: IN data packet received
                                                          * 4'b0011: IN transfer completed (triggers an interrupt)
                                                          * 4'b0101: Data toggle error (triggers an interrupt)
                                                          * 4'b0111: Channel halted (triggers an interrupt)
                                                          * Others: Reserved */
-	uint32_t dpid                         : 2;  /**< Data PID (DPID)
+		uint32_t dpid:2;		    /**< Data PID (DPID)
                                                          * 2'b00: DATA0
                                                          * 2'b10: DATA1
                                                          * 2'b01: DATA2
                                                          * 2'b11: MDATA */
-	uint32_t bcnt                         : 11; /**< Byte Count (BCnt)
+		uint32_t bcnt:11;		    /**< Byte Count (BCnt)
                                                          Indicates the byte count of the received IN data packet */
-	uint32_t chnum                        : 4;  /**< Channel Number (ChNum)
+		uint32_t chnum:4;		    /**< Channel Number (ChNum)
                                                          Indicates the channel number to which the current received
                                                          packet belongs. */
 	} s;
-	struct cvmx_usbcx_grxstsph_s          cn30xx;
-	struct cvmx_usbcx_grxstsph_s          cn31xx;
-	struct cvmx_usbcx_grxstsph_s          cn50xx;
-	struct cvmx_usbcx_grxstsph_s          cn52xx;
-	struct cvmx_usbcx_grxstsph_s          cn52xxp1;
-	struct cvmx_usbcx_grxstsph_s          cn56xx;
-	struct cvmx_usbcx_grxstsph_s          cn56xxp1;
+	struct cvmx_usbcx_grxstsph_s cn30xx;
+	struct cvmx_usbcx_grxstsph_s cn31xx;
+	struct cvmx_usbcx_grxstsph_s cn50xx;
+	struct cvmx_usbcx_grxstsph_s cn52xx;
+	struct cvmx_usbcx_grxstsph_s cn52xxp1;
+	struct cvmx_usbcx_grxstsph_s cn56xx;
+	struct cvmx_usbcx_grxstsph_s cn56xxp1;
 };
 typedef union cvmx_usbcx_grxstsph cvmx_usbcx_grxstsph_t;
 
@@ -2164,41 +2097,39 @@ typedef union cvmx_usbcx_grxstsph cvmx_usbcx_grxstsph_t;
  *       The offset difference shown in this document is for software clarity and is actually ignored by the
  *       hardware.
  */
-union cvmx_usbcx_grxstsrd
-{
+union cvmx_usbcx_grxstsrd {
 	uint32_t u32;
-	struct cvmx_usbcx_grxstsrd_s
-	{
-	uint32_t reserved_25_31               : 7;
-	uint32_t fn                           : 4;  /**< Frame Number (FN)
+	struct cvmx_usbcx_grxstsrd_s {
+		uint32_t reserved_25_31:7;
+		uint32_t fn:4;			    /**< Frame Number (FN)
                                                          This is the least significant 4 bits of the (micro)frame number in
                                                          which the packet is received on the USB.  This field is supported
                                                          only when the isochronous OUT endpoints are supported. */
-	uint32_t pktsts                       : 4;  /**< Packet Status (PktSts)
+		uint32_t pktsts:4;		    /**< Packet Status (PktSts)
                                                          Indicates the status of the received packet
                                                          * 4'b0001: Glogal OUT NAK (triggers an interrupt)
                                                          * 4'b0010: OUT data packet received
                                                          * 4'b0100: SETUP transaction completed (triggers an interrupt)
                                                          * 4'b0110: SETUP data packet received
                                                          * Others: Reserved */
-	uint32_t dpid                         : 2;  /**< Data PID (DPID)
+		uint32_t dpid:2;		    /**< Data PID (DPID)
                                                          * 2'b00: DATA0
                                                          * 2'b10: DATA1
                                                          * 2'b01: DATA2
                                                          * 2'b11: MDATA */
-	uint32_t bcnt                         : 11; /**< Byte Count (BCnt)
+		uint32_t bcnt:11;		    /**< Byte Count (BCnt)
                                                          Indicates the byte count of the received data packet */
-	uint32_t epnum                        : 4;  /**< Endpoint Number (EPNum)
+		uint32_t epnum:4;		    /**< Endpoint Number (EPNum)
                                                          Indicates the endpoint number to which the current received
                                                          packet belongs. */
 	} s;
-	struct cvmx_usbcx_grxstsrd_s          cn30xx;
-	struct cvmx_usbcx_grxstsrd_s          cn31xx;
-	struct cvmx_usbcx_grxstsrd_s          cn50xx;
-	struct cvmx_usbcx_grxstsrd_s          cn52xx;
-	struct cvmx_usbcx_grxstsrd_s          cn52xxp1;
-	struct cvmx_usbcx_grxstsrd_s          cn56xx;
-	struct cvmx_usbcx_grxstsrd_s          cn56xxp1;
+	struct cvmx_usbcx_grxstsrd_s cn30xx;
+	struct cvmx_usbcx_grxstsrd_s cn31xx;
+	struct cvmx_usbcx_grxstsrd_s cn50xx;
+	struct cvmx_usbcx_grxstsrd_s cn52xx;
+	struct cvmx_usbcx_grxstsrd_s cn52xxp1;
+	struct cvmx_usbcx_grxstsrd_s cn56xx;
+	struct cvmx_usbcx_grxstsrd_s cn56xxp1;
 };
 typedef union cvmx_usbcx_grxstsrd cvmx_usbcx_grxstsrd_t;
 
@@ -2213,37 +2144,35 @@ typedef union cvmx_usbcx_grxstsrd cvmx_usbcx_grxstsrd_t;
  *       The offset difference shown in this document is for software clarity and is actually ignored by the
  *       hardware.
  */
-union cvmx_usbcx_grxstsrh
-{
+union cvmx_usbcx_grxstsrh {
 	uint32_t u32;
-	struct cvmx_usbcx_grxstsrh_s
-	{
-	uint32_t reserved_21_31               : 11;
-	uint32_t pktsts                       : 4;  /**< Packet Status (PktSts)
+	struct cvmx_usbcx_grxstsrh_s {
+		uint32_t reserved_21_31:11;
+		uint32_t pktsts:4;		    /**< Packet Status (PktSts)
                                                          Indicates the status of the received packet
                                                          * 4'b0010: IN data packet received
                                                          * 4'b0011: IN transfer completed (triggers an interrupt)
                                                          * 4'b0101: Data toggle error (triggers an interrupt)
                                                          * 4'b0111: Channel halted (triggers an interrupt)
                                                          * Others: Reserved */
-	uint32_t dpid                         : 2;  /**< Data PID (DPID)
+		uint32_t dpid:2;		    /**< Data PID (DPID)
                                                          * 2'b00: DATA0
                                                          * 2'b10: DATA1
                                                          * 2'b01: DATA2
                                                          * 2'b11: MDATA */
-	uint32_t bcnt                         : 11; /**< Byte Count (BCnt)
+		uint32_t bcnt:11;		    /**< Byte Count (BCnt)
                                                          Indicates the byte count of the received IN data packet */
-	uint32_t chnum                        : 4;  /**< Channel Number (ChNum)
+		uint32_t chnum:4;		    /**< Channel Number (ChNum)
                                                          Indicates the channel number to which the current received
                                                          packet belongs. */
 	} s;
-	struct cvmx_usbcx_grxstsrh_s          cn30xx;
-	struct cvmx_usbcx_grxstsrh_s          cn31xx;
-	struct cvmx_usbcx_grxstsrh_s          cn50xx;
-	struct cvmx_usbcx_grxstsrh_s          cn52xx;
-	struct cvmx_usbcx_grxstsrh_s          cn52xxp1;
-	struct cvmx_usbcx_grxstsrh_s          cn56xx;
-	struct cvmx_usbcx_grxstsrh_s          cn56xxp1;
+	struct cvmx_usbcx_grxstsrh_s cn30xx;
+	struct cvmx_usbcx_grxstsrh_s cn31xx;
+	struct cvmx_usbcx_grxstsrh_s cn50xx;
+	struct cvmx_usbcx_grxstsrh_s cn52xx;
+	struct cvmx_usbcx_grxstsrh_s cn52xxp1;
+	struct cvmx_usbcx_grxstsrh_s cn56xx;
+	struct cvmx_usbcx_grxstsrh_s cn56xxp1;
 };
 typedef union cvmx_usbcx_grxstsrh cvmx_usbcx_grxstsrh_t;
 
@@ -2254,21 +2183,19 @@ typedef union cvmx_usbcx_grxstsrh cvmx_usbcx_grxstsrh_t;
  *
  * This is a read-only register that contains the release number of the core being used.
  */
-union cvmx_usbcx_gsnpsid
-{
+union cvmx_usbcx_gsnpsid {
 	uint32_t u32;
-	struct cvmx_usbcx_gsnpsid_s
-	{
-	uint32_t synopsysid                   : 32; /**< 0x4F54\<version\>A, release number of the core being used.
+	struct cvmx_usbcx_gsnpsid_s {
+		uint32_t synopsysid:32;		    /**< 0x4F54\<version\>A, release number of the core being used.
                                                          0x4F54220A => pass1.x,  0x4F54240A => pass2.x */
 	} s;
-	struct cvmx_usbcx_gsnpsid_s           cn30xx;
-	struct cvmx_usbcx_gsnpsid_s           cn31xx;
-	struct cvmx_usbcx_gsnpsid_s           cn50xx;
-	struct cvmx_usbcx_gsnpsid_s           cn52xx;
-	struct cvmx_usbcx_gsnpsid_s           cn52xxp1;
-	struct cvmx_usbcx_gsnpsid_s           cn56xx;
-	struct cvmx_usbcx_gsnpsid_s           cn56xxp1;
+	struct cvmx_usbcx_gsnpsid_s cn30xx;
+	struct cvmx_usbcx_gsnpsid_s cn31xx;
+	struct cvmx_usbcx_gsnpsid_s cn50xx;
+	struct cvmx_usbcx_gsnpsid_s cn52xx;
+	struct cvmx_usbcx_gsnpsid_s cn52xxp1;
+	struct cvmx_usbcx_gsnpsid_s cn56xx;
+	struct cvmx_usbcx_gsnpsid_s cn56xxp1;
 };
 typedef union cvmx_usbcx_gsnpsid cvmx_usbcx_gsnpsid_t;
 
@@ -2282,15 +2209,13 @@ typedef union cvmx_usbcx_gsnpsid cvmx_usbcx_gsnpsid_t;
  * before starting any transactions on either the AHB or the USB.
  * Do not make changes to this register after the initial programming.
  */
-union cvmx_usbcx_gusbcfg
-{
+union cvmx_usbcx_gusbcfg {
 	uint32_t u32;
-	struct cvmx_usbcx_gusbcfg_s
-	{
-	uint32_t reserved_17_31               : 15;
-	uint32_t otgi2csel                    : 1;  /**< UTMIFS or I2C Interface Select (OtgI2CSel)
+	struct cvmx_usbcx_gusbcfg_s {
+		uint32_t reserved_17_31:15;
+		uint32_t otgi2csel:1;		    /**< UTMIFS or I2C Interface Select (OtgI2CSel)
                                                          This bit is always 0x0. */
-	uint32_t phylpwrclksel                : 1;  /**< PHY Low-Power Clock Select (PhyLPwrClkSel)
+		uint32_t phylpwrclksel:1;	    /**< PHY Low-Power Clock Select (PhyLPwrClkSel)
                                                          Software should set this bit to 0x0.
                                                          Selects either 480-MHz or 48-MHz (low-power) PHY mode. In
                                                          FS and LS modes, the PHY can usually operate on a 48-MHz
@@ -2304,27 +2229,27 @@ union cvmx_usbcx_gusbcfg
                                                          (depending on the PHY vendor).
                                                          This bit drives the utmi_fsls_low_power core output signal, and
                                                          is valid only for UTMI+ PHYs. */
-	uint32_t reserved_14_14               : 1;
-	uint32_t usbtrdtim                    : 4;  /**< USB Turnaround Time (USBTrdTim)
+		uint32_t reserved_14_14:1;
+		uint32_t usbtrdtim:4;		    /**< USB Turnaround Time (USBTrdTim)
                                                          Sets the turnaround time in PHY clocks.
                                                          Specifies the response time for a MAC request to the Packet
                                                          FIFO Controller (PFC) to fetch data from the DFIFO (SPRAM).
                                                          This must be programmed to 0x5. */
-	uint32_t hnpcap                       : 1;  /**< HNP-Capable (HNPCap)
+		uint32_t hnpcap:1;		    /**< HNP-Capable (HNPCap)
                                                          This bit is always 0x0. */
-	uint32_t srpcap                       : 1;  /**< SRP-Capable (SRPCap)
+		uint32_t srpcap:1;		    /**< SRP-Capable (SRPCap)
                                                          This bit is always 0x0. */
-	uint32_t ddrsel                       : 1;  /**< ULPI DDR Select (DDRSel)
+		uint32_t ddrsel:1;		    /**< ULPI DDR Select (DDRSel)
                                                          Software should set this bit to 0x0. */
-	uint32_t physel                       : 1;  /**< USB 2.0 High-Speed PHY or USB 1.1 Full-Speed Serial
+		uint32_t physel:1;		    /**< USB 2.0 High-Speed PHY or USB 1.1 Full-Speed Serial
                                                          Software should set this bit to 0x0. */
-	uint32_t fsintf                       : 1;  /**< Full-Speed Serial Interface Select (FSIntf)
+		uint32_t fsintf:1;		    /**< Full-Speed Serial Interface Select (FSIntf)
                                                          Software should set this bit to 0x0. */
-	uint32_t ulpi_utmi_sel                : 1;  /**< ULPI or UTMI+ Select (ULPI_UTMI_Sel)
+		uint32_t ulpi_utmi_sel:1;	    /**< ULPI or UTMI+ Select (ULPI_UTMI_Sel)
                                                          This bit is always 0x0. */
-	uint32_t phyif                        : 1;  /**< PHY Interface (PHYIf)
+		uint32_t phyif:1;		    /**< PHY Interface (PHYIf)
                                                          This bit is always 0x1. */
-	uint32_t toutcal                      : 3;  /**< HS/FS Timeout Calibration (TOutCal)
+		uint32_t toutcal:3;		    /**< HS/FS Timeout Calibration (TOutCal)
                                                          The number of PHY clocks that the application programs in this
                                                          field is added to the high-speed/full-speed interpacket timeout
                                                          duration in the core to account for any additional delays
@@ -2344,13 +2269,13 @@ union cvmx_usbcx_gusbcfg
                                                          * One 60-MHz PHY clock = 0.2 bit times
                                                          * One 48-MHz PHY clock = 0.25 bit times */
 	} s;
-	struct cvmx_usbcx_gusbcfg_s           cn30xx;
-	struct cvmx_usbcx_gusbcfg_s           cn31xx;
-	struct cvmx_usbcx_gusbcfg_s           cn50xx;
-	struct cvmx_usbcx_gusbcfg_s           cn52xx;
-	struct cvmx_usbcx_gusbcfg_s           cn52xxp1;
-	struct cvmx_usbcx_gusbcfg_s           cn56xx;
-	struct cvmx_usbcx_gusbcfg_s           cn56xxp1;
+	struct cvmx_usbcx_gusbcfg_s cn30xx;
+	struct cvmx_usbcx_gusbcfg_s cn31xx;
+	struct cvmx_usbcx_gusbcfg_s cn50xx;
+	struct cvmx_usbcx_gusbcfg_s cn52xx;
+	struct cvmx_usbcx_gusbcfg_s cn52xxp1;
+	struct cvmx_usbcx_gusbcfg_s cn56xx;
+	struct cvmx_usbcx_gusbcfg_s cn56xxp1;
 };
 typedef union cvmx_usbcx_gusbcfg cvmx_usbcx_gusbcfg_t;
 
@@ -2365,22 +2290,20 @@ typedef union cvmx_usbcx_gusbcfg cvmx_usbcx_gusbcfg_t;
  * channel, up to a maximum of 16 bits. Bits in this register are set and cleared when the
  * application sets and clears bits in the corresponding Host Channel-n Interrupt register.
  */
-union cvmx_usbcx_haint
-{
+union cvmx_usbcx_haint {
 	uint32_t u32;
-	struct cvmx_usbcx_haint_s
-	{
-	uint32_t reserved_16_31               : 16;
-	uint32_t haint                        : 16; /**< Channel Interrupts (HAINT)
+	struct cvmx_usbcx_haint_s {
+		uint32_t reserved_16_31:16;
+		uint32_t haint:16;		    /**< Channel Interrupts (HAINT)
                                                          One bit per channel: Bit 0 for Channel 0, bit 15 for Channel 15 */
 	} s;
-	struct cvmx_usbcx_haint_s             cn30xx;
-	struct cvmx_usbcx_haint_s             cn31xx;
-	struct cvmx_usbcx_haint_s             cn50xx;
-	struct cvmx_usbcx_haint_s             cn52xx;
-	struct cvmx_usbcx_haint_s             cn52xxp1;
-	struct cvmx_usbcx_haint_s             cn56xx;
-	struct cvmx_usbcx_haint_s             cn56xxp1;
+	struct cvmx_usbcx_haint_s cn30xx;
+	struct cvmx_usbcx_haint_s cn31xx;
+	struct cvmx_usbcx_haint_s cn50xx;
+	struct cvmx_usbcx_haint_s cn52xx;
+	struct cvmx_usbcx_haint_s cn52xxp1;
+	struct cvmx_usbcx_haint_s cn56xx;
+	struct cvmx_usbcx_haint_s cn56xxp1;
 };
 typedef union cvmx_usbcx_haint cvmx_usbcx_haint_t;
 
@@ -2394,22 +2317,20 @@ typedef union cvmx_usbcx_haint cvmx_usbcx_haint_t;
  * interrupt mask bit per channel, up to a maximum of 16 bits.
  * Mask interrupt: 1'b0 Unmask interrupt: 1'b1
  */
-union cvmx_usbcx_haintmsk
-{
+union cvmx_usbcx_haintmsk {
 	uint32_t u32;
-	struct cvmx_usbcx_haintmsk_s
-	{
-	uint32_t reserved_16_31               : 16;
-	uint32_t haintmsk                     : 16; /**< Channel Interrupt Mask (HAINTMsk)
+	struct cvmx_usbcx_haintmsk_s {
+		uint32_t reserved_16_31:16;
+		uint32_t haintmsk:16;		    /**< Channel Interrupt Mask (HAINTMsk)
                                                          One bit per channel: Bit 0 for channel 0, bit 15 for channel 15 */
 	} s;
-	struct cvmx_usbcx_haintmsk_s          cn30xx;
-	struct cvmx_usbcx_haintmsk_s          cn31xx;
-	struct cvmx_usbcx_haintmsk_s          cn50xx;
-	struct cvmx_usbcx_haintmsk_s          cn52xx;
-	struct cvmx_usbcx_haintmsk_s          cn52xxp1;
-	struct cvmx_usbcx_haintmsk_s          cn56xx;
-	struct cvmx_usbcx_haintmsk_s          cn56xxp1;
+	struct cvmx_usbcx_haintmsk_s cn30xx;
+	struct cvmx_usbcx_haintmsk_s cn31xx;
+	struct cvmx_usbcx_haintmsk_s cn50xx;
+	struct cvmx_usbcx_haintmsk_s cn52xx;
+	struct cvmx_usbcx_haintmsk_s cn52xxp1;
+	struct cvmx_usbcx_haintmsk_s cn56xx;
+	struct cvmx_usbcx_haintmsk_s cn56xxp1;
 };
 typedef union cvmx_usbcx_haintmsk cvmx_usbcx_haintmsk_t;
 
@@ -2419,31 +2340,29 @@ typedef union cvmx_usbcx_haintmsk cvmx_usbcx_haintmsk_t;
  * Host Channel-n Characteristics Register (HCCHAR)
  *
  */
-union cvmx_usbcx_hccharx
-{
+union cvmx_usbcx_hccharx {
 	uint32_t u32;
-	struct cvmx_usbcx_hccharx_s
-	{
-	uint32_t chena                        : 1;  /**< Channel Enable (ChEna)
+	struct cvmx_usbcx_hccharx_s {
+		uint32_t chena:1;		    /**< Channel Enable (ChEna)
                                                          This field is set by the application and cleared by the OTG host.
                                                          * 1'b0: Channel disabled
                                                          * 1'b1: Channel enabled */
-	uint32_t chdis                        : 1;  /**< Channel Disable (ChDis)
+		uint32_t chdis:1;		    /**< Channel Disable (ChDis)
                                                          The application sets this bit to stop transmitting/receiving data
                                                          on a channel, even before the transfer for that channel is
                                                          complete. The application must wait for the Channel Disabled
                                                          interrupt before treating the channel as disabled. */
-	uint32_t oddfrm                       : 1;  /**< Odd Frame (OddFrm)
+		uint32_t oddfrm:1;		    /**< Odd Frame (OddFrm)
                                                          This field is set (reset) by the application to indicate that the
                                                          OTG host must perform a transfer in an odd (micro)frame. This
                                                          field is applicable for only periodic (isochronous and interrupt)
                                                          transactions.
                                                          * 1'b0: Even (micro)frame
                                                          * 1'b1: Odd (micro)frame */
-	uint32_t devaddr                      : 7;  /**< Device Address (DevAddr)
+		uint32_t devaddr:7;		    /**< Device Address (DevAddr)
                                                          This field selects the specific device serving as the data source
                                                          or sink. */
-	uint32_t ec                           : 2;  /**< Multi Count (MC) / Error Count (EC)
+		uint32_t ec:2;			    /**< Multi Count (MC) / Error Count (EC)
                                                          When the Split Enable bit of the Host Channel-n Split Control
                                                          register (HCSPLTn.SpltEna) is reset (1'b0), this field indicates
                                                          to the host the number of transactions that should be executed
@@ -2458,33 +2377,33 @@ union cvmx_usbcx_hccharx
                                                          number of immediate retries to be performed for a periodic split
                                                          transactions on transaction errors. This field must be set to at
                                                          least 2'b01. */
-	uint32_t eptype                       : 2;  /**< Endpoint Type (EPType)
+		uint32_t eptype:2;		    /**< Endpoint Type (EPType)
                                                          Indicates the transfer type selected.
                                                          * 2'b00: Control
                                                          * 2'b01: Isochronous
                                                          * 2'b10: Bulk
                                                          * 2'b11: Interrupt */
-	uint32_t lspddev                      : 1;  /**< Low-Speed Device (LSpdDev)
+		uint32_t lspddev:1;		    /**< Low-Speed Device (LSpdDev)
                                                          This field is set by the application to indicate that this channel is
                                                          communicating to a low-speed device. */
-	uint32_t reserved_16_16               : 1;
-	uint32_t epdir                        : 1;  /**< Endpoint Direction (EPDir)
+		uint32_t reserved_16_16:1;
+		uint32_t epdir:1;		    /**< Endpoint Direction (EPDir)
                                                          Indicates whether the transaction is IN or OUT.
                                                          * 1'b0: OUT
                                                          * 1'b1: IN */
-	uint32_t epnum                        : 4;  /**< Endpoint Number (EPNum)
+		uint32_t epnum:4;		    /**< Endpoint Number (EPNum)
                                                          Indicates the endpoint number on the device serving as the
                                                          data source or sink. */
-	uint32_t mps                          : 11; /**< Maximum Packet Size (MPS)
+		uint32_t mps:11;		    /**< Maximum Packet Size (MPS)
                                                          Indicates the maximum packet size of the associated endpoint. */
 	} s;
-	struct cvmx_usbcx_hccharx_s           cn30xx;
-	struct cvmx_usbcx_hccharx_s           cn31xx;
-	struct cvmx_usbcx_hccharx_s           cn50xx;
-	struct cvmx_usbcx_hccharx_s           cn52xx;
-	struct cvmx_usbcx_hccharx_s           cn52xxp1;
-	struct cvmx_usbcx_hccharx_s           cn56xx;
-	struct cvmx_usbcx_hccharx_s           cn56xxp1;
+	struct cvmx_usbcx_hccharx_s cn30xx;
+	struct cvmx_usbcx_hccharx_s cn31xx;
+	struct cvmx_usbcx_hccharx_s cn50xx;
+	struct cvmx_usbcx_hccharx_s cn52xx;
+	struct cvmx_usbcx_hccharx_s cn52xxp1;
+	struct cvmx_usbcx_hccharx_s cn56xx;
+	struct cvmx_usbcx_hccharx_s cn56xxp1;
 };
 typedef union cvmx_usbcx_hccharx cvmx_usbcx_hccharx_t;
 
@@ -2495,13 +2414,11 @@ typedef union cvmx_usbcx_hccharx cvmx_usbcx_hccharx_t;
  *
  * This register configures the core after power-on. Do not make changes to this register after initializing the host.
  */
-union cvmx_usbcx_hcfg
-{
+union cvmx_usbcx_hcfg {
 	uint32_t u32;
-	struct cvmx_usbcx_hcfg_s
-	{
-	uint32_t reserved_3_31                : 29;
-	uint32_t fslssupp                     : 1;  /**< FS- and LS-Only Support (FSLSSupp)
+	struct cvmx_usbcx_hcfg_s {
+		uint32_t reserved_3_31:29;
+		uint32_t fslssupp:1;		    /**< FS- and LS-Only Support (FSLSSupp)
                                                          The application uses this bit to control the core's enumeration
                                                          speed. Using this bit, the application can make the core
                                                          enumerate as a FS host, even if the connected device supports
@@ -2510,7 +2427,7 @@ union cvmx_usbcx_hcfg
                                                          * 1'b0: HS/FS/LS, based on the maximum speed supported by
                                                            the connected device
                                                          * 1'b1: FS/LS-only, even if the connected device can support HS */
-	uint32_t fslspclksel                  : 2;  /**< FS/LS PHY Clock Select (FSLSPclkSel)
+		uint32_t fslspclksel:2;		    /**< FS/LS PHY Clock Select (FSLSPclkSel)
                                                          When the core is in FS Host mode
                                                          * 2'b00: PHY clock is running at 30/60 MHz
                                                          * 2'b01: PHY clock is running at 48 MHz
@@ -2529,13 +2446,13 @@ union cvmx_usbcx_hcfg
                                                                   do a soft reset.
                                                          * 2'b11: Reserved */
 	} s;
-	struct cvmx_usbcx_hcfg_s              cn30xx;
-	struct cvmx_usbcx_hcfg_s              cn31xx;
-	struct cvmx_usbcx_hcfg_s              cn50xx;
-	struct cvmx_usbcx_hcfg_s              cn52xx;
-	struct cvmx_usbcx_hcfg_s              cn52xxp1;
-	struct cvmx_usbcx_hcfg_s              cn56xx;
-	struct cvmx_usbcx_hcfg_s              cn56xxp1;
+	struct cvmx_usbcx_hcfg_s cn30xx;
+	struct cvmx_usbcx_hcfg_s cn31xx;
+	struct cvmx_usbcx_hcfg_s cn50xx;
+	struct cvmx_usbcx_hcfg_s cn52xx;
+	struct cvmx_usbcx_hcfg_s cn52xxp1;
+	struct cvmx_usbcx_hcfg_s cn56xx;
+	struct cvmx_usbcx_hcfg_s cn56xxp1;
 };
 typedef union cvmx_usbcx_hcfg cvmx_usbcx_hcfg_t;
 
@@ -2551,35 +2468,33 @@ typedef union cvmx_usbcx_hcfg cvmx_usbcx_hcfg_t;
  * Interrupt register. The application must clear the appropriate bit in this register to clear the
  * corresponding bits in the HAINT and GINTSTS registers.
  */
-union cvmx_usbcx_hcintx
-{
+union cvmx_usbcx_hcintx {
 	uint32_t u32;
-	struct cvmx_usbcx_hcintx_s
-	{
-	uint32_t reserved_11_31               : 21;
-	uint32_t datatglerr                   : 1;  /**< Data Toggle Error (DataTglErr) */
-	uint32_t frmovrun                     : 1;  /**< Frame Overrun (FrmOvrun) */
-	uint32_t bblerr                       : 1;  /**< Babble Error (BblErr) */
-	uint32_t xacterr                      : 1;  /**< Transaction Error (XactErr) */
-	uint32_t nyet                         : 1;  /**< NYET Response Received Interrupt (NYET) */
-	uint32_t ack                          : 1;  /**< ACK Response Received Interrupt (ACK) */
-	uint32_t nak                          : 1;  /**< NAK Response Received Interrupt (NAK) */
-	uint32_t stall                        : 1;  /**< STALL Response Received Interrupt (STALL) */
-	uint32_t ahberr                       : 1;  /**< This bit is always 0x0. */
-	uint32_t chhltd                       : 1;  /**< Channel Halted (ChHltd)
+	struct cvmx_usbcx_hcintx_s {
+		uint32_t reserved_11_31:21;
+		uint32_t datatglerr:1;		    /**< Data Toggle Error (DataTglErr) */
+		uint32_t frmovrun:1;		    /**< Frame Overrun (FrmOvrun) */
+		uint32_t bblerr:1;		    /**< Babble Error (BblErr) */
+		uint32_t xacterr:1;		    /**< Transaction Error (XactErr) */
+		uint32_t nyet:1;		    /**< NYET Response Received Interrupt (NYET) */
+		uint32_t ack:1;			    /**< ACK Response Received Interrupt (ACK) */
+		uint32_t nak:1;			    /**< NAK Response Received Interrupt (NAK) */
+		uint32_t stall:1;		    /**< STALL Response Received Interrupt (STALL) */
+		uint32_t ahberr:1;		    /**< This bit is always 0x0. */
+		uint32_t chhltd:1;		    /**< Channel Halted (ChHltd)
                                                          Indicates the transfer completed abnormally either because of
                                                          any USB transaction error or in response to disable request by
                                                          the application. */
-	uint32_t xfercompl                    : 1;  /**< Transfer Completed (XferCompl)
+		uint32_t xfercompl:1;		    /**< Transfer Completed (XferCompl)
                                                          Transfer completed normally without any errors. */
 	} s;
-	struct cvmx_usbcx_hcintx_s            cn30xx;
-	struct cvmx_usbcx_hcintx_s            cn31xx;
-	struct cvmx_usbcx_hcintx_s            cn50xx;
-	struct cvmx_usbcx_hcintx_s            cn52xx;
-	struct cvmx_usbcx_hcintx_s            cn52xxp1;
-	struct cvmx_usbcx_hcintx_s            cn56xx;
-	struct cvmx_usbcx_hcintx_s            cn56xxp1;
+	struct cvmx_usbcx_hcintx_s cn30xx;
+	struct cvmx_usbcx_hcintx_s cn31xx;
+	struct cvmx_usbcx_hcintx_s cn50xx;
+	struct cvmx_usbcx_hcintx_s cn52xx;
+	struct cvmx_usbcx_hcintx_s cn52xxp1;
+	struct cvmx_usbcx_hcintx_s cn56xx;
+	struct cvmx_usbcx_hcintx_s cn56xxp1;
 };
 typedef union cvmx_usbcx_hcintx cvmx_usbcx_hcintx_t;
 
@@ -2591,31 +2506,29 @@ typedef union cvmx_usbcx_hcintx cvmx_usbcx_hcintx_t;
  * This register reflects the mask for each channel status described in the previous section.
  * Mask interrupt: 1'b0 Unmask interrupt: 1'b1
  */
-union cvmx_usbcx_hcintmskx
-{
+union cvmx_usbcx_hcintmskx {
 	uint32_t u32;
-	struct cvmx_usbcx_hcintmskx_s
-	{
-	uint32_t reserved_11_31               : 21;
-	uint32_t datatglerrmsk                : 1;  /**< Data Toggle Error Mask (DataTglErrMsk) */
-	uint32_t frmovrunmsk                  : 1;  /**< Frame Overrun Mask (FrmOvrunMsk) */
-	uint32_t bblerrmsk                    : 1;  /**< Babble Error Mask (BblErrMsk) */
-	uint32_t xacterrmsk                   : 1;  /**< Transaction Error Mask (XactErrMsk) */
-	uint32_t nyetmsk                      : 1;  /**< NYET Response Received Interrupt Mask (NyetMsk) */
-	uint32_t ackmsk                       : 1;  /**< ACK Response Received Interrupt Mask (AckMsk) */
-	uint32_t nakmsk                       : 1;  /**< NAK Response Received Interrupt Mask (NakMsk) */
-	uint32_t stallmsk                     : 1;  /**< STALL Response Received Interrupt Mask (StallMsk) */
-	uint32_t ahberrmsk                    : 1;  /**< AHB Error Mask (AHBErrMsk) */
-	uint32_t chhltdmsk                    : 1;  /**< Channel Halted Mask (ChHltdMsk) */
-	uint32_t xfercomplmsk                 : 1;  /**< Transfer Completed Mask (XferComplMsk) */
+	struct cvmx_usbcx_hcintmskx_s {
+		uint32_t reserved_11_31:21;
+		uint32_t datatglerrmsk:1;	    /**< Data Toggle Error Mask (DataTglErrMsk) */
+		uint32_t frmovrunmsk:1;		    /**< Frame Overrun Mask (FrmOvrunMsk) */
+		uint32_t bblerrmsk:1;		    /**< Babble Error Mask (BblErrMsk) */
+		uint32_t xacterrmsk:1;		    /**< Transaction Error Mask (XactErrMsk) */
+		uint32_t nyetmsk:1;		    /**< NYET Response Received Interrupt Mask (NyetMsk) */
+		uint32_t ackmsk:1;		    /**< ACK Response Received Interrupt Mask (AckMsk) */
+		uint32_t nakmsk:1;		    /**< NAK Response Received Interrupt Mask (NakMsk) */
+		uint32_t stallmsk:1;		    /**< STALL Response Received Interrupt Mask (StallMsk) */
+		uint32_t ahberrmsk:1;		    /**< AHB Error Mask (AHBErrMsk) */
+		uint32_t chhltdmsk:1;		    /**< Channel Halted Mask (ChHltdMsk) */
+		uint32_t xfercomplmsk:1;	    /**< Transfer Completed Mask (XferComplMsk) */
 	} s;
-	struct cvmx_usbcx_hcintmskx_s         cn30xx;
-	struct cvmx_usbcx_hcintmskx_s         cn31xx;
-	struct cvmx_usbcx_hcintmskx_s         cn50xx;
-	struct cvmx_usbcx_hcintmskx_s         cn52xx;
-	struct cvmx_usbcx_hcintmskx_s         cn52xxp1;
-	struct cvmx_usbcx_hcintmskx_s         cn56xx;
-	struct cvmx_usbcx_hcintmskx_s         cn56xxp1;
+	struct cvmx_usbcx_hcintmskx_s cn30xx;
+	struct cvmx_usbcx_hcintmskx_s cn31xx;
+	struct cvmx_usbcx_hcintmskx_s cn50xx;
+	struct cvmx_usbcx_hcintmskx_s cn52xx;
+	struct cvmx_usbcx_hcintmskx_s cn52xxp1;
+	struct cvmx_usbcx_hcintmskx_s cn56xx;
+	struct cvmx_usbcx_hcintmskx_s cn56xxp1;
 };
 typedef union cvmx_usbcx_hcintmskx cvmx_usbcx_hcintmskx_t;
 
@@ -2625,19 +2538,17 @@ typedef union cvmx_usbcx_hcintmskx cvmx_usbcx_hcintmskx_t;
  * Host Channel-n Split Control Register (HCSPLT)
  *
  */
-union cvmx_usbcx_hcspltx
-{
+union cvmx_usbcx_hcspltx {
 	uint32_t u32;
-	struct cvmx_usbcx_hcspltx_s
-	{
-	uint32_t spltena                      : 1;  /**< Split Enable (SpltEna)
+	struct cvmx_usbcx_hcspltx_s {
+		uint32_t spltena:1;		    /**< Split Enable (SpltEna)
                                                          The application sets this field to indicate that this channel is
                                                          enabled to perform split transactions. */
-	uint32_t reserved_17_30               : 14;
-	uint32_t compsplt                     : 1;  /**< Do Complete Split (CompSplt)
+		uint32_t reserved_17_30:14;
+		uint32_t compsplt:1;		    /**< Do Complete Split (CompSplt)
                                                          The application sets this field to request the OTG host to
                                                          perform a complete split transaction. */
-	uint32_t xactpos                      : 2;  /**< Transaction Position (XactPos)
+		uint32_t xactpos:2;		    /**< Transaction Position (XactPos)
                                                          This field is used to determine whether to send all, first, middle,
                                                          or last payloads with each OUT transaction.
                                                          * 2'b11: All. This is the entire data payload is of this transaction
@@ -2648,20 +2559,20 @@ union cvmx_usbcx_hcspltx
                                                                   (which is larger than 188 bytes).
                                                          * 2'b01: End. This is the last payload of this transaction (which
                                                                   is larger than 188 bytes). */
-	uint32_t hubaddr                      : 7;  /**< Hub Address (HubAddr)
+		uint32_t hubaddr:7;		    /**< Hub Address (HubAddr)
                                                          This field holds the device address of the transaction
                                                          translator's hub. */
-	uint32_t prtaddr                      : 7;  /**< Port Address (PrtAddr)
+		uint32_t prtaddr:7;		    /**< Port Address (PrtAddr)
                                                          This field is the port number of the recipient transaction
                                                          translator. */
 	} s;
-	struct cvmx_usbcx_hcspltx_s           cn30xx;
-	struct cvmx_usbcx_hcspltx_s           cn31xx;
-	struct cvmx_usbcx_hcspltx_s           cn50xx;
-	struct cvmx_usbcx_hcspltx_s           cn52xx;
-	struct cvmx_usbcx_hcspltx_s           cn52xxp1;
-	struct cvmx_usbcx_hcspltx_s           cn56xx;
-	struct cvmx_usbcx_hcspltx_s           cn56xxp1;
+	struct cvmx_usbcx_hcspltx_s cn30xx;
+	struct cvmx_usbcx_hcspltx_s cn31xx;
+	struct cvmx_usbcx_hcspltx_s cn50xx;
+	struct cvmx_usbcx_hcspltx_s cn52xx;
+	struct cvmx_usbcx_hcspltx_s cn52xxp1;
+	struct cvmx_usbcx_hcspltx_s cn56xx;
+	struct cvmx_usbcx_hcspltx_s cn56xxp1;
 };
 typedef union cvmx_usbcx_hcspltx cvmx_usbcx_hcspltx_t;
 
@@ -2671,14 +2582,12 @@ typedef union cvmx_usbcx_hcspltx cvmx_usbcx_hcspltx_t;
  * Host Channel-n Transfer Size Register (HCTSIZ)
  *
  */
-union cvmx_usbcx_hctsizx
-{
+union cvmx_usbcx_hctsizx {
 	uint32_t u32;
-	struct cvmx_usbcx_hctsizx_s
-	{
-	uint32_t dopng                        : 1;  /**< Do Ping (DoPng)
+	struct cvmx_usbcx_hctsizx_s {
+		uint32_t dopng:1;		    /**< Do Ping (DoPng)
                                                          Setting this field to 1 directs the host to do PING protocol. */
-	uint32_t pid                          : 2;  /**< PID (Pid)
+		uint32_t pid:2;			    /**< PID (Pid)
                                                          The application programs this field with the type of PID to use
                                                          for the initial transaction. The host will maintain this field for the
                                                          rest of the transfer.
@@ -2686,14 +2595,14 @@ union cvmx_usbcx_hctsizx
                                                          * 2'b01: DATA2
                                                          * 2'b10: DATA1
                                                          * 2'b11: MDATA (non-control)/SETUP (control) */
-	uint32_t pktcnt                       : 10; /**< Packet Count (PktCnt)
+		uint32_t pktcnt:10;		    /**< Packet Count (PktCnt)
                                                          This field is programmed by the application with the expected
                                                          number of packets to be transmitted (OUT) or received (IN).
                                                          The host decrements this count on every successful
                                                          transmission or reception of an OUT/IN packet. Once this count
                                                          reaches zero, the application is interrupted to indicate normal
                                                          completion. */
-	uint32_t xfersize                     : 19; /**< Transfer Size (XferSize)
+		uint32_t xfersize:19;		    /**< Transfer Size (XferSize)
                                                          For an OUT, this field is the number of data bytes the host will
                                                          send during the transfer.
                                                          For an IN, this field is the buffer size that the application has
@@ -2701,13 +2610,13 @@ union cvmx_usbcx_hctsizx
                                                          program this field as an integer multiple of the maximum packet
                                                          size for IN transactions (periodic and non-periodic). */
 	} s;
-	struct cvmx_usbcx_hctsizx_s           cn30xx;
-	struct cvmx_usbcx_hctsizx_s           cn31xx;
-	struct cvmx_usbcx_hctsizx_s           cn50xx;
-	struct cvmx_usbcx_hctsizx_s           cn52xx;
-	struct cvmx_usbcx_hctsizx_s           cn52xxp1;
-	struct cvmx_usbcx_hctsizx_s           cn56xx;
-	struct cvmx_usbcx_hctsizx_s           cn56xxp1;
+	struct cvmx_usbcx_hctsizx_s cn30xx;
+	struct cvmx_usbcx_hctsizx_s cn31xx;
+	struct cvmx_usbcx_hctsizx_s cn50xx;
+	struct cvmx_usbcx_hctsizx_s cn52xx;
+	struct cvmx_usbcx_hctsizx_s cn52xxp1;
+	struct cvmx_usbcx_hctsizx_s cn56xx;
+	struct cvmx_usbcx_hctsizx_s cn56xxp1;
 };
 typedef union cvmx_usbcx_hctsizx cvmx_usbcx_hctsizx_t;
 
@@ -2718,13 +2627,11 @@ typedef union cvmx_usbcx_hctsizx cvmx_usbcx_hctsizx_t;
  *
  * This register stores the frame interval information for the current speed to which the O2P USB core has enumerated.
  */
-union cvmx_usbcx_hfir
-{
+union cvmx_usbcx_hfir {
 	uint32_t u32;
-	struct cvmx_usbcx_hfir_s
-	{
-	uint32_t reserved_16_31               : 16;
-	uint32_t frint                        : 16; /**< Frame Interval (FrInt)
+	struct cvmx_usbcx_hfir_s {
+		uint32_t reserved_16_31:16;
+		uint32_t frint:16;		    /**< Frame Interval (FrInt)
                                                          The value that the application programs to this field specifies
                                                          the interval between two consecutive SOFs (FS) or micro-
                                                          SOFs (HS) or Keep-Alive tokens (HS). This field contains the
@@ -2741,13 +2648,13 @@ union cvmx_usbcx_hfir
                                                          * 125 us (PHY clock frequency for HS)
                                                          * 1 ms (PHY clock frequency for FS/LS) */
 	} s;
-	struct cvmx_usbcx_hfir_s              cn30xx;
-	struct cvmx_usbcx_hfir_s              cn31xx;
-	struct cvmx_usbcx_hfir_s              cn50xx;
-	struct cvmx_usbcx_hfir_s              cn52xx;
-	struct cvmx_usbcx_hfir_s              cn52xxp1;
-	struct cvmx_usbcx_hfir_s              cn56xx;
-	struct cvmx_usbcx_hfir_s              cn56xxp1;
+	struct cvmx_usbcx_hfir_s cn30xx;
+	struct cvmx_usbcx_hfir_s cn31xx;
+	struct cvmx_usbcx_hfir_s cn50xx;
+	struct cvmx_usbcx_hfir_s cn52xx;
+	struct cvmx_usbcx_hfir_s cn52xxp1;
+	struct cvmx_usbcx_hfir_s cn56xx;
+	struct cvmx_usbcx_hfir_s cn56xxp1;
 };
 typedef union cvmx_usbcx_hfir cvmx_usbcx_hfir_t;
 
@@ -2760,28 +2667,26 @@ typedef union cvmx_usbcx_hfir cvmx_usbcx_hfir_t;
  * It also indicates the time remaining (in terms of the number of PHY clocks)
  * in the current (micro)frame.
  */
-union cvmx_usbcx_hfnum
-{
+union cvmx_usbcx_hfnum {
 	uint32_t u32;
-	struct cvmx_usbcx_hfnum_s
-	{
-	uint32_t frrem                        : 16; /**< Frame Time Remaining (FrRem)
+	struct cvmx_usbcx_hfnum_s {
+		uint32_t frrem:16;		    /**< Frame Time Remaining (FrRem)
                                                          Indicates the amount of time remaining in the current
                                                          microframe (HS) or frame (FS/LS), in terms of PHY clocks.
                                                          This field decrements on each PHY clock. When it reaches
                                                          zero, this field is reloaded with the value in the Frame Interval
                                                          register and a new SOF is transmitted on the USB. */
-	uint32_t frnum                        : 16; /**< Frame Number (FrNum)
+		uint32_t frnum:16;		    /**< Frame Number (FrNum)
                                                          This field increments when a new SOF is transmitted on the
                                                          USB, and is reset to 0 when it reaches 16'h3FFF. */
 	} s;
-	struct cvmx_usbcx_hfnum_s             cn30xx;
-	struct cvmx_usbcx_hfnum_s             cn31xx;
-	struct cvmx_usbcx_hfnum_s             cn50xx;
-	struct cvmx_usbcx_hfnum_s             cn52xx;
-	struct cvmx_usbcx_hfnum_s             cn52xxp1;
-	struct cvmx_usbcx_hfnum_s             cn56xx;
-	struct cvmx_usbcx_hfnum_s             cn56xxp1;
+	struct cvmx_usbcx_hfnum_s cn30xx;
+	struct cvmx_usbcx_hfnum_s cn31xx;
+	struct cvmx_usbcx_hfnum_s cn50xx;
+	struct cvmx_usbcx_hfnum_s cn52xx;
+	struct cvmx_usbcx_hfnum_s cn52xxp1;
+	struct cvmx_usbcx_hfnum_s cn56xx;
+	struct cvmx_usbcx_hfnum_s cn56xxp1;
 };
 typedef union cvmx_usbcx_hfnum cvmx_usbcx_hfnum_t;
 
@@ -2799,19 +2704,17 @@ typedef union cvmx_usbcx_hfnum cvmx_usbcx_hfnum_t;
  * the bit that caused the interrupt. For the R_SS_WC bits, the application must write a 1 to the bit
  * to clear the interrupt.
  */
-union cvmx_usbcx_hprt
-{
+union cvmx_usbcx_hprt {
 	uint32_t u32;
-	struct cvmx_usbcx_hprt_s
-	{
-	uint32_t reserved_19_31               : 13;
-	uint32_t prtspd                       : 2;  /**< Port Speed (PrtSpd)
+	struct cvmx_usbcx_hprt_s {
+		uint32_t reserved_19_31:13;
+		uint32_t prtspd:2;		    /**< Port Speed (PrtSpd)
                                                          Indicates the speed of the device attached to this port.
                                                          * 2'b00: High speed
                                                          * 2'b01: Full speed
                                                          * 2'b10: Low speed
                                                          * 2'b11: Reserved */
-	uint32_t prttstctl                    : 4;  /**< Port Test Control (PrtTstCtl)
+		uint32_t prttstctl:4;		    /**< Port Test Control (PrtTstCtl)
                                                          The application writes a nonzero value to this field to put
                                                          the port into a Test mode, and the corresponding pattern is
                                                          signaled on the port.
@@ -2824,17 +2727,17 @@ union cvmx_usbcx_hprt
                                                          * Others: Reserved
                                                          PrtSpd must be zero (i.e. the interface must be in high-speed
                                                          mode) to use the PrtTstCtl test modes. */
-	uint32_t prtpwr                       : 1;  /**< Port Power (PrtPwr)
+		uint32_t prtpwr:1;		    /**< Port Power (PrtPwr)
                                                          The application uses this field to control power to this port,
                                                          and the core clears this bit on an overcurrent condition.
                                                          * 1'b0: Power off
                                                          * 1'b1: Power on */
-	uint32_t prtlnsts                     : 2;  /**< Port Line Status (PrtLnSts)
+		uint32_t prtlnsts:2;		    /**< Port Line Status (PrtLnSts)
                                                          Indicates the current logic level USB data lines
                                                          * Bit [10]: Logic level of D-
                                                          * Bit [11]: Logic level of D+ */
-	uint32_t reserved_9_9                 : 1;
-	uint32_t prtrst                       : 1;  /**< Port Reset (PrtRst)
+		uint32_t reserved_9_9:1;
+		uint32_t prtrst:1;		    /**< Port Reset (PrtRst)
                                                          When the application sets this bit, a reset sequence is
                                                          started on this port. The application must time the reset
                                                          period and clear this bit after the reset sequence is
@@ -2849,7 +2752,7 @@ union cvmx_usbcx_hprt
                                                          USB standard.
                                                          * High speed: 50 ms
                                                          * Full speed/Low speed: 10 ms */
-	uint32_t prtsusp                      : 1;  /**< Port Suspend (PrtSusp)
+		uint32_t prtsusp:1;		    /**< Port Suspend (PrtSusp)
                                                          The application sets this bit to put this port in Suspend
                                                          mode. The core only stops sending SOFs when this is set.
                                                          To stop the PHY clock, the application must set the Port
@@ -2865,7 +2768,7 @@ union cvmx_usbcx_hprt
                                                          respectively).
                                                          * 1'b0: Port not in Suspend mode
                                                          * 1'b1: Port in Suspend mode */
-	uint32_t prtres                       : 1;  /**< Port Resume (PrtRes)
+		uint32_t prtres:1;		    /**< Port Resume (PrtRes)
                                                          The application sets this bit to drive resume signaling on
                                                          the port. The core continues to drive the resume signal
                                                          until the application clears this bit.
@@ -2879,17 +2782,17 @@ union cvmx_usbcx_hprt
                                                          resume signaling.
                                                          * 1'b0: No resume driven
                                                          * 1'b1: Resume driven */
-	uint32_t prtovrcurrchng               : 1;  /**< Port Overcurrent Change (PrtOvrCurrChng)
+		uint32_t prtovrcurrchng:1;	    /**< Port Overcurrent Change (PrtOvrCurrChng)
                                                          The core sets this bit when the status of the Port
                                                          Overcurrent Active bit (bit 4) in this register changes. */
-	uint32_t prtovrcurract                : 1;  /**< Port Overcurrent Active (PrtOvrCurrAct)
+		uint32_t prtovrcurract:1;	    /**< Port Overcurrent Active (PrtOvrCurrAct)
                                                          Indicates the overcurrent condition of the port.
                                                          * 1'b0: No overcurrent condition
                                                          * 1'b1: Overcurrent condition */
-	uint32_t prtenchng                    : 1;  /**< Port Enable/Disable Change (PrtEnChng)
+		uint32_t prtenchng:1;		    /**< Port Enable/Disable Change (PrtEnChng)
                                                          The core sets this bit when the status of the Port Enable bit
                                                          [2] of this register changes. */
-	uint32_t prtena                       : 1;  /**< Port Enable (PrtEna)
+		uint32_t prtena:1;		    /**< Port Enable (PrtEna)
                                                          A port is enabled only by the core after a reset sequence,
                                                          and is disabled by an overcurrent condition, a disconnect
                                                          condition, or by the application clearing this bit. The
@@ -2898,23 +2801,23 @@ union cvmx_usbcx_hprt
                                                          interrupt to the application.
                                                          * 1'b0: Port disabled
                                                          * 1'b1: Port enabled */
-	uint32_t prtconndet                   : 1;  /**< Port Connect Detected (PrtConnDet)
+		uint32_t prtconndet:1;		    /**< Port Connect Detected (PrtConnDet)
                                                          The core sets this bit when a device connection is detected
                                                          to trigger an interrupt to the application using the Host Port
                                                          Interrupt bit of the Core Interrupt register (GINTSTS.PrtInt).
                                                          The application must write a 1 to this bit to clear the
                                                          interrupt. */
-	uint32_t prtconnsts                   : 1;  /**< Port Connect Status (PrtConnSts)
+		uint32_t prtconnsts:1;		    /**< Port Connect Status (PrtConnSts)
                                                          * 0: No device is attached to the port.
                                                          * 1: A device is attached to the port. */
 	} s;
-	struct cvmx_usbcx_hprt_s              cn30xx;
-	struct cvmx_usbcx_hprt_s              cn31xx;
-	struct cvmx_usbcx_hprt_s              cn50xx;
-	struct cvmx_usbcx_hprt_s              cn52xx;
-	struct cvmx_usbcx_hprt_s              cn52xxp1;
-	struct cvmx_usbcx_hprt_s              cn56xx;
-	struct cvmx_usbcx_hprt_s              cn56xxp1;
+	struct cvmx_usbcx_hprt_s cn30xx;
+	struct cvmx_usbcx_hprt_s cn31xx;
+	struct cvmx_usbcx_hprt_s cn50xx;
+	struct cvmx_usbcx_hprt_s cn52xx;
+	struct cvmx_usbcx_hprt_s cn52xxp1;
+	struct cvmx_usbcx_hprt_s cn56xx;
+	struct cvmx_usbcx_hprt_s cn56xxp1;
 };
 typedef union cvmx_usbcx_hprt cvmx_usbcx_hprt_t;
 
@@ -2925,24 +2828,22 @@ typedef union cvmx_usbcx_hprt cvmx_usbcx_hprt_t;
  *
  * This register holds the size and the memory start address of the Periodic TxFIFO, as shown in Figures 310 and 311.
  */
-union cvmx_usbcx_hptxfsiz
-{
+union cvmx_usbcx_hptxfsiz {
 	uint32_t u32;
-	struct cvmx_usbcx_hptxfsiz_s
-	{
-	uint32_t ptxfsize                     : 16; /**< Host Periodic TxFIFO Depth (PTxFSize)
+	struct cvmx_usbcx_hptxfsiz_s {
+		uint32_t ptxfsize:16;		    /**< Host Periodic TxFIFO Depth (PTxFSize)
                                                          This value is in terms of 32-bit words.
                                                          * Minimum value is 16
                                                          * Maximum value is 32768 */
-	uint32_t ptxfstaddr                   : 16; /**< Host Periodic TxFIFO Start Address (PTxFStAddr) */
+		uint32_t ptxfstaddr:16;		    /**< Host Periodic TxFIFO Start Address (PTxFStAddr) */
 	} s;
-	struct cvmx_usbcx_hptxfsiz_s          cn30xx;
-	struct cvmx_usbcx_hptxfsiz_s          cn31xx;
-	struct cvmx_usbcx_hptxfsiz_s          cn50xx;
-	struct cvmx_usbcx_hptxfsiz_s          cn52xx;
-	struct cvmx_usbcx_hptxfsiz_s          cn52xxp1;
-	struct cvmx_usbcx_hptxfsiz_s          cn56xx;
-	struct cvmx_usbcx_hptxfsiz_s          cn56xxp1;
+	struct cvmx_usbcx_hptxfsiz_s cn30xx;
+	struct cvmx_usbcx_hptxfsiz_s cn31xx;
+	struct cvmx_usbcx_hptxfsiz_s cn50xx;
+	struct cvmx_usbcx_hptxfsiz_s cn52xx;
+	struct cvmx_usbcx_hptxfsiz_s cn52xxp1;
+	struct cvmx_usbcx_hptxfsiz_s cn56xx;
+	struct cvmx_usbcx_hptxfsiz_s cn56xxp1;
 };
 typedef union cvmx_usbcx_hptxfsiz cvmx_usbcx_hptxfsiz_t;
 
@@ -2954,12 +2855,10 @@ typedef union cvmx_usbcx_hptxfsiz cvmx_usbcx_hptxfsiz_t;
  * This read-only register contains the free space information for the Periodic TxFIFO and
  * the Periodic Transmit Request Queue
  */
-union cvmx_usbcx_hptxsts
-{
+union cvmx_usbcx_hptxsts {
 	uint32_t u32;
-	struct cvmx_usbcx_hptxsts_s
-	{
-	uint32_t ptxqtop                      : 8;  /**< Top of the Periodic Transmit Request Queue (PTxQTop)
+	struct cvmx_usbcx_hptxsts_s {
+		uint32_t ptxqtop:8;		    /**< Top of the Periodic Transmit Request Queue (PTxQTop)
                                                          This indicates the entry in the Periodic Tx Request Queue that
                                                          is currently being processes by the MAC.
                                                          This register is used for debugging.
@@ -2974,7 +2873,7 @@ union cvmx_usbcx_hptxsts
                                                            - 2'b11: Disable channel command
                                                          * Bit [24]: Terminate (last entry for the selected
                                                            channel/endpoint) */
-	uint32_t ptxqspcavail                 : 8;  /**< Periodic Transmit Request Queue Space Available
+		uint32_t ptxqspcavail:8;	    /**< Periodic Transmit Request Queue Space Available
                                                          (PTxQSpcAvail)
                                                          Indicates the number of free locations available to be written in
                                                          the Periodic Transmit Request Queue. This queue holds both
@@ -2984,7 +2883,7 @@ union cvmx_usbcx_hptxsts
                                                          * 8'h2: 2 locations available
                                                          * n: n locations available (0..8)
                                                          * Others: Reserved */
-	uint32_t ptxfspcavail                 : 16; /**< Periodic Transmit Data FIFO Space Available (PTxFSpcAvail)
+		uint32_t ptxfspcavail:16;	    /**< Periodic Transmit Data FIFO Space Available (PTxFSpcAvail)
                                                          Indicates the number of free locations available to be written to
                                                          in the Periodic TxFIFO.
                                                          Values are in terms of 32-bit words
@@ -2995,13 +2894,13 @@ union cvmx_usbcx_hptxsts
                                                          * 16'h8000: 32768 words available
                                                          * Others: Reserved */
 	} s;
-	struct cvmx_usbcx_hptxsts_s           cn30xx;
-	struct cvmx_usbcx_hptxsts_s           cn31xx;
-	struct cvmx_usbcx_hptxsts_s           cn50xx;
-	struct cvmx_usbcx_hptxsts_s           cn52xx;
-	struct cvmx_usbcx_hptxsts_s           cn52xxp1;
-	struct cvmx_usbcx_hptxsts_s           cn56xx;
-	struct cvmx_usbcx_hptxsts_s           cn56xxp1;
+	struct cvmx_usbcx_hptxsts_s cn30xx;
+	struct cvmx_usbcx_hptxsts_s cn31xx;
+	struct cvmx_usbcx_hptxsts_s cn50xx;
+	struct cvmx_usbcx_hptxsts_s cn52xx;
+	struct cvmx_usbcx_hptxsts_s cn52xxp1;
+	struct cvmx_usbcx_hptxsts_s cn56xx;
+	struct cvmx_usbcx_hptxsts_s cn56xxp1;
 };
 typedef union cvmx_usbcx_hptxsts cvmx_usbcx_hptxsts_t;
 
@@ -3012,20 +2911,18 @@ typedef union cvmx_usbcx_hptxsts cvmx_usbcx_hptxsts_t;
  *
  * A slave mode application uses this register to access the Tx FIFO for channel n.
  */
-union cvmx_usbcx_nptxdfifox
-{
+union cvmx_usbcx_nptxdfifox {
 	uint32_t u32;
-	struct cvmx_usbcx_nptxdfifox_s
-	{
-	uint32_t data                         : 32; /**< Reserved */
+	struct cvmx_usbcx_nptxdfifox_s {
+		uint32_t data:32;		    /**< Reserved */
 	} s;
-	struct cvmx_usbcx_nptxdfifox_s        cn30xx;
-	struct cvmx_usbcx_nptxdfifox_s        cn31xx;
-	struct cvmx_usbcx_nptxdfifox_s        cn50xx;
-	struct cvmx_usbcx_nptxdfifox_s        cn52xx;
-	struct cvmx_usbcx_nptxdfifox_s        cn52xxp1;
-	struct cvmx_usbcx_nptxdfifox_s        cn56xx;
-	struct cvmx_usbcx_nptxdfifox_s        cn56xxp1;
+	struct cvmx_usbcx_nptxdfifox_s cn30xx;
+	struct cvmx_usbcx_nptxdfifox_s cn31xx;
+	struct cvmx_usbcx_nptxdfifox_s cn50xx;
+	struct cvmx_usbcx_nptxdfifox_s cn52xx;
+	struct cvmx_usbcx_nptxdfifox_s cn52xxp1;
+	struct cvmx_usbcx_nptxdfifox_s cn56xx;
+	struct cvmx_usbcx_nptxdfifox_s cn56xxp1;
 };
 typedef union cvmx_usbcx_nptxdfifox cvmx_usbcx_nptxdfifox_t;
 
@@ -3036,13 +2933,11 @@ typedef union cvmx_usbcx_nptxdfifox cvmx_usbcx_nptxdfifox_t;
  *
  * The application can use this register to control the core's power-down and clock gating features.
  */
-union cvmx_usbcx_pcgcctl
-{
+union cvmx_usbcx_pcgcctl {
 	uint32_t u32;
-	struct cvmx_usbcx_pcgcctl_s
-	{
-	uint32_t reserved_5_31                : 27;
-	uint32_t physuspended                 : 1;  /**< PHY Suspended. (PhySuspended)
+	struct cvmx_usbcx_pcgcctl_s {
+		uint32_t reserved_5_31:27;
+		uint32_t physuspended:1;	    /**< PHY Suspended. (PhySuspended)
                                                          Indicates that the PHY has been suspended. After the
                                                          application sets the Stop Pclk bit (bit 0), this bit is updated once
                                                          the PHY is suspended.
@@ -3051,35 +2946,35 @@ union cvmx_usbcx_pcgcctl
                                                          However, the ULPI PHY takes a few clocks to suspend,
                                                          because the suspend information is conveyed through the ULPI
                                                          protocol to the ULPI PHY. */
-	uint32_t rstpdwnmodule                : 1;  /**< Reset Power-Down Modules (RstPdwnModule)
+		uint32_t rstpdwnmodule:1;	    /**< Reset Power-Down Modules (RstPdwnModule)
                                                          This bit is valid only in Partial Power-Down mode. The
                                                          application sets this bit when the power is turned off. The
                                                          application clears this bit after the power is turned on and the
                                                          PHY clock is up. */
-	uint32_t pwrclmp                      : 1;  /**< Power Clamp (PwrClmp)
+		uint32_t pwrclmp:1;		    /**< Power Clamp (PwrClmp)
                                                          This bit is only valid in Partial Power-Down mode. The
                                                          application sets this bit before the power is turned off to clamp
                                                          the signals between the power-on modules and the power-off
                                                          modules. The application clears the bit to disable the clamping
                                                          before the power is turned on. */
-	uint32_t gatehclk                     : 1;  /**< Gate Hclk (GateHclk)
+		uint32_t gatehclk:1;		    /**< Gate Hclk (GateHclk)
                                                          The application sets this bit to gate hclk to modules other than
                                                          the AHB Slave and Master and wakeup logic when the USB is
                                                          suspended or the session is not valid. The application clears
                                                          this bit when the USB is resumed or a new session starts. */
-	uint32_t stoppclk                     : 1;  /**< Stop Pclk (StopPclk)
+		uint32_t stoppclk:1;		    /**< Stop Pclk (StopPclk)
                                                          The application sets this bit to stop the PHY clock (phy_clk)
                                                          when the USB is suspended, the session is not valid, or the
                                                          device is disconnected. The application clears this bit when the
                                                          USB is resumed or a new session starts. */
 	} s;
-	struct cvmx_usbcx_pcgcctl_s           cn30xx;
-	struct cvmx_usbcx_pcgcctl_s           cn31xx;
-	struct cvmx_usbcx_pcgcctl_s           cn50xx;
-	struct cvmx_usbcx_pcgcctl_s           cn52xx;
-	struct cvmx_usbcx_pcgcctl_s           cn52xxp1;
-	struct cvmx_usbcx_pcgcctl_s           cn56xx;
-	struct cvmx_usbcx_pcgcctl_s           cn56xxp1;
+	struct cvmx_usbcx_pcgcctl_s cn30xx;
+	struct cvmx_usbcx_pcgcctl_s cn31xx;
+	struct cvmx_usbcx_pcgcctl_s cn50xx;
+	struct cvmx_usbcx_pcgcctl_s cn52xx;
+	struct cvmx_usbcx_pcgcctl_s cn52xxp1;
+	struct cvmx_usbcx_pcgcctl_s cn56xx;
+	struct cvmx_usbcx_pcgcctl_s cn56xxp1;
 };
 typedef union cvmx_usbcx_pcgcctl cvmx_usbcx_pcgcctl_t;
 
-- 
1.7.10.4
