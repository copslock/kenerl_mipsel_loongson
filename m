Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2005 12:01:57 +0100 (BST)
Received: from mercury.mv.net ([IPv6:::ffff:199.125.85.40]:13811 "HELO
	mercury.mv.net") by linux-mips.org with SMTP id <S8224850AbVDFLBl>;
	Wed, 6 Apr 2005 12:01:41 +0100
Received: (qmail 2939 invoked from network); 6 Apr 2005 07:01:39 -0400
Received: from 24-234-116-82.ptp.lvcm.net (HELO lithium) (firefly-bv@24.234.116.82)
  by mercury.mv.net with SMTP; 6 Apr 2005 07:01:39 -0400
X-Peer-Info: remote-ip 24.234.116.82 local-ip 199.125.85.40
  local-name mercury.mv.net
Reply-To: <bvacaliuc@ngit.com>
From:	"Bogdan Vacaliuc" <bvacaliuc@firefly.mv.com>
To:	"'Dan Malek'" <dan@embeddededge.com>,
	"'Gilad Rom'" <gilad@romat.com>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: Gigabit Ethernet
Date:	Wed, 6 Apr 2005 07:01:25 -0400
Organization: NGI Technology, LLC
Message-ID: <002b01c53a98$0211ad00$0b03a8c0@lithium>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <62642b91fa50ac5f881ed8fa9400deed@embeddededge.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Return-Path: <bvacaliuc@firefly.mv.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bvacaliuc@firefly.mv.com
Precedence: bulk
X-list: linux-mips

On Tuesday, March 22, 2005 4:04 PM, Dan Malek wrote:

> On Mar 22, 2005, at 11:56 AM, Gilad Rom wrote:
> 
>> Has anyone ever tried using a Gigabit PCI
>> adapter with one of the Au1x00 boards? Any success?
> 
> Just remember that the Au1x00 boards are 32-bit , 33 MHz,
> 3.3V PCI, so choose your boards accordingly.  Please don't expect the
> Au1x00 to run the TCP/IP stack anywhere near Gigabit speeds ..... :-)

We have researching this topic for a little while, particularly from the FPGA standpoint.  Although not specific to MIPS, I offer a
few links which discuss the considerations for successfully sustaining gigabit ethernet transport.

The "Gigabit System Reference Design", pg. 49 offers some benchmarks obtained using MontaVista Linux on a PowerPC 405.  Key
takeaways are that the data payload must not be handled by the stack (DMA direct from framebuffer/fifo/sdram) and must use jumbo
(5000,9000) ethernet frames.

Best Regards,

-bogdan

---

EE Times, "Altera Demonstrates FPGA for video-over-IP", March 2005,
http://www.embedded.com/showArticle.jhtml?articleID=159903648 

Altera, "Video Over IP Reference Design", March 2005,
http://www.altera.com/solutions/refdesigns/sys-sol/broadcast/ref-video.html

Xilinx, "Gigabit System Reference Design", June 2004,
http://direct.xilinx.com/bvdocs/appnotes/xapp536.pdf 

Xilinx, "Considerations for High-Bandwidth TCP/IP PowerPC Applications", XCell Journal pg.14-16, Winter 2004,
http://www.xilinx.com/publications/xcellonline/xcell_51/xc_pdf/xc_xcell51.pdf 

Marco Riccioli, Xilinx "Getting the most TCP/IP from your Embedded Processor", Embedded World 2005,
http://www.treck.com/xilinx.pdf
