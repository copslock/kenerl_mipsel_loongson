Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jan 2003 16:10:37 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:32700 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225203AbTATQKh>; Mon, 20 Jan 2003 16:10:37 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA06703;
	Mon, 20 Jan 2003 17:10:41 +0100 (MET)
Date: Mon, 20 Jan 2003 17:10:41 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Justin Pauley <jpauley@xwizards.com>
cc: linux-mips@linux-mips.org
Subject: Re: Mopd Directions
In-Reply-To: <1042907706.3331.206.camel@Opus>
Message-ID: <Pine.GSO.3.96.1030120170316.4801C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sat, 18 Jan 2003, Justin Pauley wrote:

> The directions are at http://www.xwizards.com/MopLinuxDec.html 

 You don't need to turn the promiscuous mode on, unless you have a strange
network card, for which there is no multicast support in the kernel.  You
probably don't want, either, as with a busy network the mode hurts
performance a lot, stealing processor's cycles for throwing useless frames
away.  The mopd daemon binds to multicast MAC addresses it's interested
in. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
