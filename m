Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5E7if412215
	for linux-mips-outgoing; Thu, 14 Jun 2001 00:44:41 -0700
Received: from mailgate3.cinetic.de (mailgate3.cinetic.de [212.227.116.80])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5E7idP12206
	for <linux-mips@oss.sgi.com>; Thu, 14 Jun 2001 00:44:39 -0700
Received: from smtp.web.de (smtp01.web.de [194.45.170.210])
	by mailgate3.cinetic.de (8.11.2/8.11.2/SuSE Linux 8.11.0-0.4) with SMTP id f5E7ibF13477;
	Thu, 14 Jun 2001 09:44:37 +0200
Received: from intel by smtp.web.de with smtp
	(freemail 4.2.1.8 #22) id m15ARnw-007naqC; Thu, 14 Jun 2001 09:44 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
From: Harald Koerfgen <hkoerfg@web.de>
Organization: none to speak of
To: Jun Sun <jsun@mvista.com>, "H . J . Lu" <hjl@lucon.org>
Subject: Re: A new mips toolchain is available
Date: Wed, 13 Jun 2001 22:55:00 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-mips@oss.sgi.com
References: <20010613082417.C9739@lucon.org> <20010613084416.A10334@lucon.org> <3B27B56F.65BAE189@mvista.com>
In-Reply-To: <3B27B56F.65BAE189@mvista.com>
MIME-Version: 1.0
Message-Id: <01061322550001.00617@intel>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wednesday 13 June 2001 20:48, Jun Sun wrote:
> The latest CVS tree removed MIPS_ATOMIC_SET for CPUs without ll/sc.  See
> the diff below.

[diff snipped]

> It seems that the checkin is a mistake because apparently it is not what
> linux-vr is doing.  They used to have a piece of code for CPUs without
> ll/sc. And recently they moved to ll/sc instruction emulation.

Well, you seem to have a different linux-vr tree than I do :-)

> Ralf, the following patch includes the original vr code for
> MIPS_ATOMIC_SET, no ll/sc case.  Although we all know it is buggy (for
> small negative set values), it is still better than nothing.

Anyway, the linux-vr source tree has a partially working ll/sc emulation, at 
least enough for glibc, and MIPS_ATOMIC_SET is not neccessarily needed.
In fact, MIPS_ATOMIC_SET has been removed from the vr tree.

Regards,
Harald
