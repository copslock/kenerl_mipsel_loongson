Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Feb 2011 12:28:57 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:45252 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490981Ab1BXL2y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Feb 2011 12:28:54 +0100
Received: by wyf23 with SMTP id 23so405194wyf.36
        for <multiple recipients>; Thu, 24 Feb 2011 03:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=oMxKhlE43hc5cZ/u1Yi5GvxQdBauK7wMNFeSk90Tmms=;
        b=E8AtBi/FzEfFRyRu5ZBbSYRZ0ZGg8l2fwZmzUWAIcYhKYfmr8tSau9HrLgHeHgy/hE
         axC5oY083XFiBGTq5Iuz1TWpjnKQAKy2H74dPWJZMOz3yUz2zlI5Yjr5/6FDtghk3MVo
         4pAXH0LVb39nahVaxHDkeAMjfbctytwDFeYVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=XzwYNrNdavqPo/7n0PuWYlDDPB2dByCVzSIceq3FrMPb2Fi2+SAIq2FxIsBar6n0Ry
         nuV5WXe5SR3fJFjCqSbFYe04wtN97lL+FxPMGzrYAogwgQBqR+sXM1aeMtVH6nyyejxm
         1t0tVHJU/TgvV466geKVvLG23lQyBo/yatW0Q=
Received: by 10.227.157.141 with SMTP id b13mr633908wbx.96.1298546928829;
        Thu, 24 Feb 2011 03:28:48 -0800 (PST)
Received: from bicker ([212.49.88.34])
        by mx.google.com with ESMTPS id u9sm1564094wbg.18.2011.02.24.03.28.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 03:28:47 -0800 (PST)
Date:   Thu, 24 Feb 2011 14:28:19 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Anoop P A <anoop.pa@gmail.com>
Cc:     "gregkh @ suse . de" <gregkh@suse.de>,
        "dbrownell @ users . sourceforge . net" 
        <dbrownell@users.sourceforge.net>,
        "stern @ rowland . harvard . edu" <stern@rowland.harvard.edu>,
        "pkondeti @ codeaurora . org" <pkondeti@codeaurora.org>,
        "jacob . jun . pan @ intel . com" <jacob.jun.pan@intel.com>,
        "linux-usb @ vger . kernel . org" <linux-usb@vger.kernel.org>,
        "alek . du @ intel . com" <alek.du@intel.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        "gadiyar @ ti . com" <gadiyar@ti.com>,
        "ralf @ linux-mips . org" <ralf@linux-mips.org>,
        "linux-mips @ linux-mips . org" <linux-mips@linux-mips.org>,
        Greg KH <greg@kroah.com>
Subject: Re: [PATCH v5] EHCI bus glue for on-chip PMC MSP USB controller
Message-ID: <20110224110138.GA28665@bicker>
Mail-Followup-To: Dan Carpenter <error27@gmail.com>,
        Anoop P A <anoop.pa@gmail.com>,
        "gregkh @ suse . de" <gregkh@suse.de>,
        "dbrownell @ users . sourceforge . net" <dbrownell@users.sourceforge.net>,
        "stern @ rowland . harvard . edu" <stern@rowland.harvard.edu>,
        "pkondeti @ codeaurora . org" <pkondeti@codeaurora.org>,
        "jacob . jun . pan @ intel . com" <jacob.jun.pan@intel.com>,
        "linux-usb @ vger . kernel . org" <linux-usb@vger.kernel.org>,
        "alek . du @ intel . com" <alek.du@intel.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        "gadiyar @ ti . com" <gadiyar@ti.com>,
        "ralf @ linux-mips . org" <ralf@linux-mips.org>,
        "linux-mips @ linux-mips . org" <linux-mips@linux-mips.org>,
        Greg KH <greg@kroah.com>
References: <4D5ABB65.3090101@parrot.com>
 <1298388933-13707-1-git-send-email-anoop.pa@gmail.com>
 <20110222200427.GB1966@bicker>
 <1298467343.9950.119.camel@paanoop1-desktop>
 <20110223170205.GE19898@bicker>
 <1298542755.9950.277.camel@paanoop1-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1298542755.9950.277.camel@paanoop1-desktop>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <error27@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: error27@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Feb 24, 2011 at 03:49:15PM +0530, Anoop P A wrote:
> > Also this is dead code.  No one will complain, if you just delete it.
> You mean entire ehci_msp_suspend() ??
> 

Sure why not?  It's not really ready to submit.  People can't complain
about it if you don't submit it.

(Understand that I'm from the peanut gallery.  I'm not in anyway a 
maintainer of this code and my suggestions carry very little weight).

regards,
dan carpenter
