Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g398oi8d009493
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 9 Apr 2002 01:50:44 -0700
Received: (from mail@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g398oiiT009492
	for linux-mips-outgoing; Tue, 9 Apr 2002 01:50:44 -0700
X-Authentication-Warning: oss.sgi.com: mail set sender to owner-linux-mips@oss.sgi.com using -f
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g398ob8d009488
	for <linux-mips@oss.sgi.com>; Tue, 9 Apr 2002 01:50:41 -0700
Received: from excalibur.cologne.de (pD9E40558.dip.t-dialin.net [217.228.5.88])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id KAA07834;
	Tue, 9 Apr 2002 10:50:56 +0200 (MET DST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 16uqxt-0000GG-00; Tue, 09 Apr 2002 10:26:57 +0200
Date: Tue, 9 Apr 2002 10:26:57 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: Muthukumar Ratty <muthu5@sbcglobal.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: Where to get the latest kernel.
Message-ID: <20020409102657.C254@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	Muthukumar Ratty <muthu5@sbcglobal.net>, linux-mips@oss.sgi.com
References: <Pine.LNX.4.33.0204082128480.25181-100000@Muruga.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0204082128480.25181-100000@Muruga.localdomain>; from muthu5@sbcglobal.net on Mon, Apr 08, 2002 at 09:33:57PM -0700
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 08, 2002 at 09:33:57PM -0700, Muthukumar Ratty wrote:

> Where can I download the latest development kernel for MIPS?

cvs -d :pserver:cvs@oss.sgi.com:/cvs login
(no password)
cvs -z4 -d :pserver:cvs@oss.sgi.com:/cvs co linux

or if you would like to get kernel version 2.4.x:

cvs -z4 -d :pserver:cvs@oss.sgi.com:/cvs co -r linux_2_4 linux

HTH,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
