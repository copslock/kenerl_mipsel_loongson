Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Dec 2004 13:42:53 +0000 (GMT)
Received: from server212.com ([IPv6:::ffff:203.194.159.163]:44171 "HELO
	server212.com") by linux-mips.org with SMTP id <S8224933AbULKNmt>;
	Sat, 11 Dec 2004 13:42:49 +0000
Received: (qmail 20026 invoked by uid 2003); 11 Dec 2004 13:43:05 -0000
Message-ID: <20041211134305.22769.qmail@server212.com>
Reply-To: "wlacey" <wlacey@goldenhindresearch.com>
From: "wlacey" <wlacey@goldenhindresearch.com>
To: linux-mips@linux-mips.org
Subject: No PCI_AUTO in 2.6...
Date: Sat, 11 Dec 2004 13:43:05 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="_ba3a001bb191b9756e5715dab9227106c"
X-Mailer: WebMail 2.3
X-Originating-IP: 67.149.145.76
X-Originating-Email: wlacey@goldenhindresearch.com
Return-Path: <wlacey@goldenhindresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wlacey@goldenhindresearch.com
Precedence: bulk
X-list: linux-mips

--_ba3a001bb191b9756e5715dab9227106c
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Might someone be willing to share a bit knowledge with me?

I've transitioned to the 2.6.10 kernel and I'm having a difficult time understanding what things I must do different to get my pci slots probed as before in 2.4. At this point I'm well aware the 2.6 is not a drop in replacement for 2.4 but what is the a general approach to getting something like PCI_AUTO capability in 2.6 what steps must I take and is there document describing them.

I call register_pci_controller() but the bus is never scanned becasue pcibios_init() fails out with...
"Skipping PCI bus scan due to resource conflict"

Any hints/clues/breadcrumbs for the starving?

Thanks,
W


--_ba3a001bb191b9756e5715dab9227106c
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Might someone be willing to share a bit knowledge with me?<br>
<br>
I've transitioned to the 2.6.10 kernel and I'm having a difficult time understanding what things I must do different to get my pci slots probed as before in 2.4. At this point I'm well aware the 2.6 is not a drop in replacement for 2.4 but what is the a general approach to getting something like PCI_AUTO capability in 2.6 what steps must I take and is there document describing them.<br>
<br>
I call register_pci_controller() but the bus is never scanned becasue pcibios_init() fails out with...<br>
&quot;Skipping PCI bus scan due to resource conflict&quot;<br>
<br>
Any hints/clues/breadcrumbs for the starving?<br>
<br>
Thanks,<br>
W<br>
<br>


--_ba3a001bb191b9756e5715dab9227106c--
