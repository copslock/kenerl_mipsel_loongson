Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIBjGw31667
	for linux-mips-outgoing; Tue, 18 Dec 2001 03:45:16 -0800
Received: from hlubocky.del.cz (hlubocky.del.cz [212.27.221.67])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBIBjDo31664
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 03:45:14 -0800
Received: from ladis (helo=localhost)
	by hlubocky.del.cz with local-esmtp (Exim 3.12 #1 (Debian))
	id 16GHk2-0004ca-00; Tue, 18 Dec 2001 11:44:58 +0100
Date: Tue, 18 Dec 2001 11:44:57 +0100 (CET)
From: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
To: Greg MATTHEWS <G.Matthews@cs.ucl.ac.uk>
cc: linux-mips@oss.sgi.com, debian-mips@lists.debian.org
Subject: Re: Console corruption with newport & XFree86
In-Reply-To: <4498.1008671659@cs.ucl.ac.uk>
Message-ID: <Pine.LNX.4.21.0112181138270.17409-100000@hlubocky.del.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from QUOTED-PRINTABLE to 8bit by oss.sgi.com id fBIBjEo31665
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 18 Dec 2001, Greg MATTHEWS wrote:

> under what circumstances does corruption take place on the relevant newport?

1) boot kernel with newport_con included
2) start xserver
3) switch back to VT
   - everything okay? happy you...
   - do you see blank screen and only cursor is visible? (typical
     case). Report it to Guido.

laïa
