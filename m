Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8QHkbu26238
	for linux-mips-outgoing; Wed, 26 Sep 2001 10:46:37 -0700
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8QHkYD26235
	for <linux-mips@oss.sgi.com>; Wed, 26 Sep 2001 10:46:34 -0700
Received: from excalibur.cologne.de (pD951104D.dip.t-dialin.net [217.81.16.77])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id TAA07347;
	Wed, 26 Sep 2001 19:46:27 +0200 (MET DST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 15mHq2-00008k-00; Wed, 26 Sep 2001 18:47:10 +0200
Date: Wed, 26 Sep 2001 18:47:10 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: Marc Karasek <marc_karasek@ivivity.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: busybox does not like 2.4.8, or the other way around?
Message-ID: <20010926184710.D348@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	Marc Karasek <marc_karasek@ivivity.com>, Jun Sun <jsun@mvista.com>,
	linux-mips@oss.sgi.com
References: <25369470B6F0D41194820002B328BDD2195AA2@ATLOPS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <25369470B6F0D41194820002B328BDD2195AA2@ATLOPS>; from marc_karasek@ivivity.com on Wed, Sep 26, 2001 at 11:53:39AM -0400
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Sep 26, 2001 at 11:53:39AM -0400, Marc Karasek wrote:

[busybox does not react to a keypress]
> Yes, there was a bug in busybox that caused this.  I helped track it down a
> few months ago and it should be fixed in the latest one.  I have attached an
> email about the bug.  What version(s) of busybox are you using?

busybox 0.60.1-2 (current version from Debian/Sid)

> > I'm using busybox as init/getty/shell.
> > 
> > Everything works fine with 2.4.2.
> > With 2.4.3 console output is fine but not input.

Hm, this seems to be another problem - 2.4.3 and 2.4.5 work fine for me,
anything newer than 2.4.5 does not. I suppose we have a kernel problem
after 2.4.5 as kernels newer than 2.4.5 completely crash on a DECstation 
sooner or later during bootup.

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
