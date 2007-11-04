Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2007 20:04:25 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.184]:26161 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20031057AbXKDUEP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Nov 2007 20:04:15 +0000
Received: by nf-out-0910.google.com with SMTP id c10so980591nfd
        for <linux-mips@linux-mips.org>; Sun, 04 Nov 2007 12:04:05 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=773ZBL/AJovEwPAGlxLJafYre52Kq2ruKRg+HmH4sOg=;
        b=khg2A+zXFJOj1cQvu9zY9ZrpaEDXHdq+UsM+dHc8HL1BP4Hg80MgRHMRcDSZi3+Y2hCsI6pikhbV1FM598RFkhyZtESZK71BQyNN9VgaXPDDvhhkL9CiR2ZQBwOXusTbFslWpnbmrp0yx7lN0KzsdiMJmGRuTlz1cFWqqaficX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=I/Ehm+gkbvkSDpP1WpMgSfdx6qNIq8Y3iD/YX2PO7H61t2vCdOn7s+ulRpLsuqruemT/HRAnRV34B3bxUr0hy3lIn0j84n9iQIzIBdWO8fyzgjosGtOnbEBQEd7QvXppHMmTPKPvSIhqX4LluTzeAm5Lim7lOOL9WiIaQ8/AzQU=
Received: by 10.86.60.7 with SMTP id i7mr2782252fga.1194206645645;
        Sun, 04 Nov 2007 12:04:05 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id f31sm10567379fkf.2007.11.04.12.04.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Nov 2007 12:04:05 -0800 (PST)
Message-ID: <472E2570.3020403@gmail.com>
Date:	Sun, 04 Nov 2007 21:02:56 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Kill __bzero()
References: <472D8058.5080209@gmail.com> <20071105.004208.74752504.anemo@mba.ocn.ne.jp>
In-Reply-To: <20071105.004208.74752504.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Sun, 04 Nov 2007 09:18:32 +0100, Franck Bui-Huu <fbuihuu@gmail.com> wrote:
>>   2/ For the caller, it makes no difference to call memset instead
>>   since it has to setup the second parameter of __bzero to 0.
> 
> __bzero() does not clobber v0 but memset() does.  I don't know if gcc
> does some magical thing to protect v0, but it would be safer to add v0
> explicitly to clobber-list of __clear_user().
> 

good catch ! I'll do it.

thanks
		Franck
