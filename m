Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBFNSt127710
	for linux-mips-outgoing; Sat, 15 Dec 2001 15:28:55 -0800
Received: from mail.frosty-geek.net (gtso-c3477b5b.dsl.mediaWays.net [195.71.123.91])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBFNSro27707
	for <linux-mips@oss.sgi.com>; Sat, 15 Dec 2001 15:28:53 -0800
Received: from nautilus.noreply.org (unknown [138.232.34.77])
	by mail.frosty-geek.net (Postfix) with ESMTP
	id 748AF46C295; Sat, 15 Dec 2001 23:28:40 +0100 (CET)
Received: by nautilus.noreply.org (Postfix, from userid 10)
	id C8ACB357C4; Sat, 15 Dec 2001 23:28:39 +0100 (CET)
Received: by fisch.cyrius.com (Postfix, from userid 1000)
	id 3946C22A95; Sat, 15 Dec 2001 23:29:48 +0100 (CET)
Date: Sat, 15 Dec 2001 23:29:48 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Karsten Merker <karsten@excalibur.cologne.de>,
   debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: Re: DELO problems
Message-ID: <20011215232947.A5851@fisch.cyrius.com>
References: <20011215230150.B2636@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011215230150.B2636@excalibur.cologne.de>
User-Agent: Mutt/1.3.22i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

* Karsten Merker <karsten@excalibur.cologne.de> [20011215 23:01]:
> I cannot get delo to boot any recently built kernel - delo loads 
> /etc/delo.conf, finds the correct kernel image and loads it,
> printing "Loading /boot/vmlinux ....... ok", but when the kernel
> itself should be startet (and print "This DECstation is a ...."),
> I get the firmware prompt again.

Flo posted a patch for this.  I will send it to you in private mail
and file a bug on delo (delo in Debian is up for adoption, btw).

-- 
Martin Michlmayr
tbm@cyrius.com
