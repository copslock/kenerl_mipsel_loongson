Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1P76JY14229
	for linux-mips-outgoing; Sun, 24 Feb 2002 23:06:19 -0800
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1P76C914202
	for <linux-mips@oss.sgi.com>; Sun, 24 Feb 2002 23:06:15 -0800
Received: from excalibur.cologne.de (p508519A6.dip.t-dialin.net [80.133.25.166])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id HAA24893;
	Mon, 25 Feb 2002 07:05:51 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 16fENx-00007r-00; Mon, 25 Feb 2002 07:13:17 +0100
Date: Mon, 25 Feb 2002 07:13:16 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: Robert Rusek <robru@teknuts.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Latest kernel?
Message-ID: <20020225071315.A256@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	Robert Rusek <robru@teknuts.com>, linux-mips@oss.sgi.com
References: <20020220221507.GC29624@paradigm.rfc822.org> <001401c1bda6$352f7d10$6601a8c0@delllaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001401c1bda6$352f7d10$6601a8c0@delllaptop>; from robru@teknuts.com on Sun, Feb 24, 2002 at 06:43:17PM -0800
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Feb 24, 2002 at 06:43:17PM -0800, Robert Rusek wrote:

> I checked the oss.sgi.com cvs and they do not seem to have linux_2_4
> only linux-2.4-xfs.  Is that what I am looking for?  Will that give me a
> working 2.4.x kernel?

cvs -z3 -d :pserver:cvs@oss.sgi.com:/cvs co -rlinux_2_4 linux

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
