Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g49H8LwJ004283
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 9 May 2002 10:08:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g49H8LTx004282
	for linux-mips-outgoing; Thu, 9 May 2002 10:08:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g49H8HwJ004271
	for <linux-mips@oss.sgi.com>; Thu, 9 May 2002 10:08:18 -0700
Received: from excalibur.cologne.de (pD9E40480.dip.t-dialin.net [217.228.4.128])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id TAA00470;
	Thu, 9 May 2002 19:09:42 +0200 (MET DST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 175rZx-0000kF-00; Thu, 09 May 2002 19:19:45 +0200
Date: Thu, 9 May 2002 19:19:45 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: James Simmons <jsimmons@transvirtual.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Debian on Indy.
Message-ID: <20020509191945.K1913@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	James Simmons <jsimmons@transvirtual.com>, linux-mips@oss.sgi.com
References: <Pine.LNX.4.10.10205090938350.9983-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10205090938350.9983-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Thu, May 09, 2002 at 09:40:11AM -0700
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, May 09, 2002 at 09:40:11AM -0700, James Simmons wrote:
> 
> I just recently attempted to install debian on a new indy I just got. I
> entered the prom boot console and typed bootp()/tftpboot/tfptboot.img. It
> failed. What steps am I missing?

Without more information on how it failed that is difficult to tell.
Any logfile entries on the bootp/tftp server?
Have you looked at http://www.linux-mips.org/technical_faq.html?
There you can find a list of possible problems when netbooting an Indy.

HTH,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
