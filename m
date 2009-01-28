Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2009 22:40:12 +0000 (GMT)
Received: from ey-out-1920.google.com ([74.125.78.144]:44147 "EHLO
	ey-out-1920.google.com") by ftp.linux-mips.org with ESMTP
	id S21366393AbZA1WkJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Jan 2009 22:40:09 +0000
Received: by ey-out-1920.google.com with SMTP id 5so73922eyb.54
        for <linux-mips@linux-mips.org>; Wed, 28 Jan 2009 14:40:08 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=lX3TxLbIXRznA7ISqIrXnOC5RLxQh7Ak2ELRJjSQ7Q0=;
        b=sMwHvYh1SrOfAvLAS8JP0IvUzKEJ+O9K+wdNAVKAUNcjPndxWIiTrJaHV18ae5Js4O
         +9z7VaN49/1Wsv/vlxskmjtadq9OWU9D1XDNPZFCrlO0AKcgjCysayorH25zItIYf8G8
         PKh89f1t1fHdEYz7JeBGcVhuIwTFh4aZ4cjtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=vRWDqOQ+siDYexEQ8kacticgdfjq/cIuW/fi/etaOyIgd2sC86oZ4fD4eIwY01jPpK
         +xJCwtGidwySDLLF3tI/3BCNAcZDkivdfc8x2NTF3+DWNXcQmtHwbqOrGTjLwb5oHyxc
         qJKaVxI5koi2sWsaUW+1FKmzmrMS4xxKQqYmA=
Received: by 10.103.192.2 with SMTP id u2mr3003350mup.2.1233182408085;
        Wed, 28 Jan 2009 14:40:08 -0800 (PST)
Received: from flowlan.maisel.int-evry.fr ([157.159.47.25])
        by mx.google.com with ESMTPS id g1sm20931982muf.17.2009.01.28.14.40.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jan 2009 14:40:07 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
To:	linux-mips@linux-mips.org
Subject: Call for Presentation for the "Embedded Systems and Open Hardware" session of the 10th Libre Software Meeting (Nantes, France, July 2009)
Date:	Wed, 28 Jan 2009 23:39:33 +0100
User-Agent: KMail/1.9.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200901282339.33864.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Dear all,

Please find below the Call For Presentation to the LSM meeting for the 
"Embedded Systems and Open Hardware" session.

Sincerely Yours;

Florian.

===========================================================================
The Libre Software Meeting (LSM) is an annual event on free software 
taking place in july in France since 2000. The LSM meeting is organized 
this year in Nantes from 7th to 11th july.

This text is the Call For Presentation (CFP) of the "Embedded Systems 
and Open Hardware" session. The other topics can be found on the LSM Web 
site: http://2009.rmll.info/.

The embedded systems are increasingly present in our life. The embedded 
system community usually used commercial software solutions with 
royalties to reverse each time a system is sold. Since few years, a 
reversal of tendency has appeared with the use of free software for 
embedded systems. That is made possible by the adaptation of the Linux 
kernel to the constraints of atypical embedded system (no MMU, small 
memory footprint, filesystem in FLASH memory...) and its port on various 
types of processors.

Along with free software for embedded systems, Open Hardware is becoming 
more and more important. Open Hardware provides access to all the 
specifications of an electronic device design and is reproductible by 
everyone. This allows design reuse because one knows how it works. Open 
Hardware also increases its life because it can be reused in another use.

The purpose of the "Embedded Systems and Open Hardware" session is to 
give the state of the art of free software for embedded systems and Open 
Hardware.

Technical topics of this session include but are not limited to:

* Embedded OS Development kernel architecture, implementation and port 
for embedded systems
* Embedded Development Tools: tool chains and project cases (tool chain 
projects, packaging for cross compilation, portability ...)
* Embedded Linux: µClinux...
* Real-time extensions for Linux: RTLinux, RTAI...
* Hard real-time kernels: eCos, RTEMS, ADEOS, Xenomai...
* Soft Real-time kernels
* Embedded Java
* GUI for embedded systems: Gtk, Qt, Nano/X...
* Linux and System on Chip (SoC)
* Open Hardware, Open design, free IP modules (Intellectual Property) 
and softcores: opencores, OpenRISC, NIOS, Microblaze, LEONSparc, FPGA...

Submissions with industrial applications and experiences are specially 
encouraged.

Precisions for the speakers:

The conference will last 30 minutes, questions included. Round tables 
will be organized.

Synthetic presentations are scheduled to last 20 minutes. PDF versions 
of the presentation are not mandatory but they will be greatly 
appreciated (with a web online access just after the LSM event, they are 
a very useful documentation to the entire community).

If you plan to participate and to propose a presentation, please send as 
soon as possible a message to the following address: embarque at rmll.info 
with a summary of your presentation (and if you can, an english summary 
too) no later than 15th march 2009. Feel free to forward this Call For 
Presentation everywhere or to everyone you think to be interested in.

We have limited resources for public transportation (only for those who 
can not be refunded by their administration) but there is no fees for 
the conference and accommodation at very low cost is proposed on the site.

The chairmen of the "Embedded Systems and Open Hardware" for LSM ’09: 
Florian Fainelli, Patrice Kadionik, Thomas Petazzoni et Pierre Ficheux.
===========================================================================
