Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8T9Hfk31867
	for linux-mips-outgoing; Sat, 29 Sep 2001 02:17:41 -0700
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8T9HcD31863
	for <linux-mips@oss.sgi.com>; Sat, 29 Sep 2001 02:17:38 -0700
Received: from excalibur.cologne.de (lt200001.hrz.uni-oldenburg.de [134.106.156.150])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id LAA01166;
	Sat, 29 Sep 2001 11:17:20 +0200 (MET DST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 15nGK1-00009z-00; Sat, 29 Sep 2001 11:22:09 +0200
Date: Sat, 29 Sep 2001 11:22:09 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: machael <dony.he@huawei.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: What is the latest stable kernel version for MIPS?
Message-ID: <20010929112208.A466@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	machael <dony.he@huawei.com>, linux-mips@oss.sgi.com
References: <003101c147f5$a6fc5980$921c690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <003101c147f5$a6fc5980$921c690a@huawei.com>; from dony.he@huawei.com on Fri, Sep 28, 2001 at 04:14:53PM +0800
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Sep 28, 2001 at 04:14:53PM +0800, machael wrote:

> What is the latest stable kernel version for MIPS? And where can I download
> it?

Well, there is no really "stable" kernel :-).
Linux/MIPS does not have formal kernel releases, you can check out the 
current cvs version by using

cvs -d :pserver:cvs@oss.sgi.com:/cvs login
Password is "cvs"
cvs -z4 -d :pserver:cvs@oss.sgi.com:/cvs co linux

For more information, please see the Linux-MIPS-HOWTO on

http://oss.sgi.com/mips/mips-howto.html

HTH,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
