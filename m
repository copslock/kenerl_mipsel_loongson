Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4SMpDnC031836
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 28 May 2002 15:51:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4SMpDLo031835
	for linux-mips-outgoing; Tue, 28 May 2002 15:51:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from irongate.swansea.linux.org.uk (pc2-cwma1-5-cust12.swa.cable.ntl.com [80.5.121.12])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4SMpAnC031829
	for <linux-mips@oss.sgi.com>; Tue, 28 May 2002 15:51:11 -0700
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.2/8.11.6) with ESMTP id g4SNsiZ1010510;
	Wed, 29 May 2002 00:54:50 +0100
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.2/8.12.2/Submit) id g4SNsSfZ010508;
	Wed, 29 May 2002 00:54:28 +0100
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: PCI Graphics/Video Card for Malta Board?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dan Malek <dan@embeddededge.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>, Jun Sun <jsun@mvista.com>,
   Geert
	Uytterhoeven <geert@linux-m68k.org>,
   "Steven J. Hill" <sjhill@realitydiluted.com>,
   Linux/MIPS Development
	 <linux-mips@oss.sgi.com>
In-Reply-To: <3CF40273.1000801@embeddededge.com>
References: <Pine.GSO.4.21.0205271534430.15706-100000@vervain.sonytel.be>
	<3CF3B72B.4020600@mvista.com> <01da01c2066f$3ed63f40$10eca8c0@grendel> 
	<3CF40273.1000801@embeddededge.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 May 2002 00:54:27 +0100
Message-Id: <1022630067.9255.146.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Old S3 cards are very easy to configure. 3Dfx Voodoo 2 is great as we
have full code to configure it -and- it can do 3D. Alas no utah-glx
support so you can't do X with 3d on it right now.
