Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 20:09:25 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:43504 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225228AbUJTTJV>; Wed, 20 Oct 2004 20:09:21 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id D63281854F; Wed, 20 Oct 2004 12:09:14 -0700 (PDT)
Message-ID: <4176B7DA.3080900@mvista.com>
Date: Wed, 20 Oct 2004 12:09:14 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Support for header alignment in PMC-Sierra Titan 1.2 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello Ralf

This is a long standing patch that I intended to send it out to you. 
Currently, I have made this untested patch against the 2.6 version of 
the titan ge driver. The Titan 1.2 revision of the silicon supports IP 
header alignment in the MAC subsystem. I have modified the driver for 
this and have a new flag TITAN_GE_12 which uses the header alignment and 
does not do the extra copy on the Rx path that is still needed for the 
1.0 and 1.1 revision of the silicon. This works and I had tested this on 
2.4. It should work on 2.6 as well.

Thanks
Manish Lachwani

--- drivers/net/titan_ge.c.orig 2004-10-20 11:48:53.000000000 -0700
+++ drivers/net/titan_ge.c      2004-10-20 12:02:31.000000000 -0700
@@ -725,6 +725,9 @@
        volatile unsigned long reg_data, reg_data1;
        int port_num = titan_port->port_num;
        int count = 0;
+#ifdef TITAN_GE_12
+       unsigned long reg_data_1;
+#endif
 
        if (config_done == 0) {
                reg_data = TITAN_GE_READ(0x0004);
@@ -954,6 +957,28 @@
         * Step 3:  TRTG block enable
         */
        reg_data = TITAN_GE_READ(TITAN_GE_TRTG_CONFIG + (port_num << 12));
+#ifdef TITAN_GE_12
+       /*
+        * This is the 1.2 revision of the chip. It has fix for the
+        * IP header alignment. Now, the IP header begins at an
+        * aligned address and this wont need an extra copy in the
+        * driver. This performance drawback existed in the previous
+        * versions of the silicon
+        */
+       reg_data_1 = TITAN_GE_READ(0x103c + (port_num << 12));
+       reg_data_1 |= 0x40000000;
+       TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);
+
+       reg_data_1 |= 0x04000000;
+       TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);
+
+       mdelay(5);
+
+       reg_data_1 &= ~(0x04000000);
+       TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);
+
+       mdelay(5);
+#endif
        reg_data |= 0x0001;
        TITAN_GE_WRITE((TITAN_GE_TRTG_CONFIG + (port_num << 12)), reg_data);
 
@@ -1444,11 +1469,27 @@
                 * idea is to cut down the number of checks and improve
                 * the fastpath.
                 */
+#ifdef TITAN_GE_12
+               skb_put(skb, packet.len - 2);
+#else
                skb_put(skb, packet.len);
+#endif
+
+#ifdef TITAN_GE_12
+               /*
+                * Increment data pointer by two since thats where
+                * the MAC starts
+                */
+               skb_reserve(skb, 2);
+               skb->protocol = eth_type_trans(skb, netdev);
+               netif_receive_skb(skb);
+#else /* 1.0 and 1.1 revision of the silicon */
 
                if (titan_ge_slowpath(skb, &packet, netdev) < 0)
                        goto out_next;
 
+#endif
+
 #ifdef TITAN_RX_NAPI
                if (titan_ge_eth->rx_threshold > RX_THRESHOLD) {
                        ack = titan_ge_rx_task(netdev, titan_ge_eth);
