Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2004 17:49:27 +0000 (GMT)
Received: from server212.com ([IPv6:::ffff:203.194.159.163]:21737 "HELO
	server212.com") by linux-mips.org with SMTP id <S8225597AbUBYRt0>;
	Wed, 25 Feb 2004 17:49:26 +0000
Received: (qmail 10839 invoked by uid 501); 25 Feb 2004 17:50:56 -0000
Message-ID: <20040225175056.17002.qmail@server212.com>
Reply-To: "wlacey" <wlacey@goldenhindresearch.com>
From: "wlacey" <wlacey@goldenhindresearch.com>
To: linux-mips@linux-mips.org
Subject: dead RTL8139D eth
Date: Wed, 25 Feb 2004 17:50:56 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="_bc36cd5b2aab80bfed7a4852a2de6c422"
X-Mailer: WebMail 2.3
X-Originating-IP: 65.60.194.102
X-Originating-Email: wlacey@goldenhindresearch.com
Return-Path: <wlacey@goldenhindresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wlacey@goldenhindresearch.com
Precedence: bulk
X-list: linux-mips

--_bc36cd5b2aab80bfed7a4852a2de6c422
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit


I'm currently bringing up a 2.4.28 based kernel on a tx4925 equipped board attempting to use an NFS'ed root filesystem. 

The problem is I never see the initial RPC requests from the target to the host machine. The target knows via boot options it's ip address and the address of the nfs host. 

The attempt at transfer fails, I never see reception of _any_ message on the host and the interface statistics never reflect that any packet has even been attempted to be sent. i.e. tx bytes/packes are always zero.

Some output follows...

RPC: rpc_execute flgs 0
start_xmit() max(len:42   ETH_ZLEN:60) 60
Post xmit stats tx_bytes:0      tx_packets:0 tx_dropped:0
Post xmit stats rx_bytes:0      rx_packets:0 rx_dropped:0
start_xmit() max(len:42   ETH_ZLEN:60) 60
Post xmit stats tx_bytes:0      tx_packets:0 tx_dropped:0
Post xmit stats rx_bytes:0      rx_packets:0 rx_dropped:0
start_xmit() max(len:42   ETH_ZLEN:60) 60
Post xmit stats tx_bytes:0      tx_packets:0 tx_dropped:0
Post xmit stats rx_bytes:0      rx_packets:0 rx_dropped:0
start_xmit() max(len:42   ETH_ZLEN:60) 60
Post xmit stats tx_bytes:0      tx_packets:0 tx_dropped:0
Post xmit stats rx_bytes:0      rx_packets:0 rx_dropped:0
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0d 0040 media 10.
io address:00001000 inl:8014baac
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 00002000. (queue head)
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.

What am I doing wrong?

Warrick Lacey





--_bc36cd5b2aab80bfed7a4852a2de6c422
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

<br>
I'm currently bringing up a 2.4.28 based kernel on a tx4925 equipped board attempting to use an NFS'ed root filesystem. <br>
<br>
The problem is I never see the initial RPC requests from the target to the host machine. The target knows via boot options it's ip address and the address of the nfs host. <br>
<br>
The attempt at transfer fails, I never see reception of _any_ message on the host and the interface statistics never reflect that any packet has even been attempted to be sent. i.e. tx bytes/packes are always zero.<br>
<br>
Some output follows...<br>
<br>
RPC: rpc_execute flgs 0<br>
start_xmit() max(len:42   ETH_ZLEN:60) 60<br>
Post xmit stats tx_bytes:0      tx_packets:0 tx_dropped:0<br>
Post xmit stats rx_bytes:0      rx_packets:0 rx_dropped:0<br>
start_xmit() max(len:42   ETH_ZLEN:60) 60<br>
Post xmit stats tx_bytes:0      tx_packets:0 tx_dropped:0<br>
Post xmit stats rx_bytes:0      rx_packets:0 rx_dropped:0<br>
start_xmit() max(len:42   ETH_ZLEN:60) 60<br>
Post xmit stats tx_bytes:0      tx_packets:0 tx_dropped:0<br>
Post xmit stats rx_bytes:0      rx_packets:0 rx_dropped:0<br>
start_xmit() max(len:42   ETH_ZLEN:60) 60<br>
Post xmit stats tx_bytes:0      tx_packets:0 tx_dropped:0<br>
Post xmit stats rx_bytes:0      rx_packets:0 rx_dropped:0<br>
NETDEV WATCHDOG: eth0: transmit timed out<br>
eth0: Transmit timeout, status 0d 0040 media 10.<br>
io address:00001000 inl:8014baac<br>
eth0: Tx queue start entry 4  dirty entry 0.<br>
eth0:  Tx descriptor 0 is 00002000. (queue head)<br>
eth0:  Tx descriptor 1 is 00002000.<br>
eth0:  Tx descriptor 2 is 00002000.<br>
eth0:  Tx descriptor 3 is 00002000.<br>
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.<br>
<br>
What am I doing wrong?<br>
<br>
Warrick Lacey<br>
<br>
<br>
<br>
<br>


--_bc36cd5b2aab80bfed7a4852a2de6c422--
