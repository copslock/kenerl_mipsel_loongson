Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBF9l9n17505
	for linux-mips-outgoing; Sat, 15 Dec 2001 01:47:09 -0800
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBF9l5o17502
	for <linux-mips@oss.sgi.com>; Sat, 15 Dec 2001 01:47:05 -0800
Received: from excalibur.cologne.de (pD95119D2.dip.t-dialin.net [217.81.25.210])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id JAA26132
	for <linux-mips@oss.sgi.com>; Sat, 15 Dec 2001 09:47:01 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 16FADl-00008T-00
	for <linux-mips@oss.sgi.com>; Sat, 15 Dec 2001 09:31:01 +0100
Date: Sat, 15 Dec 2001 09:31:01 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@oss.sgi.com
Subject: Re: No bzImage target for MIPS
Message-ID: <20011215093101.A256@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@oss.sgi.com
References: <200112140047.fBE0l9n02204@icarus.sanera.net> <1008292240.27799.134.camel@zeus> <20011213192846.A36207@idiom.com> <1008353149.27799.144.camel@zeus> <20011214105257.A15033@idiom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011214105257.A15033@idiom.com>; from espin@idiom.com on Fri, Dec 14, 2001 at 10:52:57AM -0800
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Dec 14, 2001 at 10:52:57AM -0800, Geoffrey Espin wrote:

>     all: vmlinux.ecoff addinitrd
>     ...
> 
> BTW, does any actually build 'vmlinux.ecoff'?

Yes, it is (among other uses) the default target for DECstations,
the DECstation firmware cannot tftp-boot anything else.

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
