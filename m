Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Sep 2006 14:01:43 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.188]:25965 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037726AbWIMNBi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 13 Sep 2006 14:01:38 +0100
Received: by nf-out-0910.google.com with SMTP id l23so1940263nfc
        for <linux-mips@linux-mips.org>; Wed, 13 Sep 2006 06:01:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=bPaiGoFAjrd1LD9xsbR78TRKbAbbfzNoW3edxnUuZUoLQOaLhPYRqPRYsG6RRyPWOz0el6saUJ9eikI2HrSXTiJgVrjgPgOU4mIqFXsp9Q1FcVPvbaENhFnuk73Z6Q+TJi4O9Bqb0vnVo+3RUZq3Ff6ubnY/B4kpkacqJnqIZhY=
Received: by 10.49.21.8 with SMTP id y8mr10892818nfi;
        Wed, 13 Sep 2006 06:01:37 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id c10sm17170788nfb.2006.09.13.06.01.36;
        Wed, 13 Sep 2006 06:01:37 -0700 (PDT)
Message-ID: <45080148.3000104@innova-card.com>
Date:	Wed, 13 Sep 2006 15:02:00 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: Patches
References: <200609122247.19091.thomas@koeller.dyndns.org> <20060913122746.GA10177@linux-mips.org>
In-Reply-To: <20060913122746.GA10177@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Sep 12, 2006 at 10:47:19PM +0200, Thomas Koeller wrote:
> 
>> what about these patches:
>> http://www.linux-mips.org/archives/linux-mips/2006-08/msg00271.html
>> http://www.linux-mips.org/archives/linux-mips/2006-08/msg00270.html
>>
>> Are you going to apply them?
> 
> They've been applied to the queue branch weeks ago.  Due to the still
> unmerged RM92xx seriver driver I didn't consider it 2.6.18 material.
> 

and what about ?

http://www.linux-mips.org/archives/linux-mips/2006-08/msg00112.html
http://www.linux-mips.org/archives/linux-mips/2006-08/msg00113.html
http://www.linux-mips.org/archives/linux-mips/2006-08/msg00114.html
http://www.linux-mips.org/archives/linux-mips/2006-08/msg00115.html
http://www.linux-mips.org/archives/linux-mips/2006-08/msg00117.html
http://www.linux-mips.org/archives/linux-mips/2006-08/msg00118.html

and these ones too ?

http://www.linux-mips.org/archives/linux-mips/2006-08/msg00196.html
http://www.linux-mips.org/archives/linux-mips/2006-08/msg00195.html
http://www.linux-mips.org/archives/linux-mips/2006-08/msg00197.html

BTW, mainline doesn't seem to merge MIPS repo anymore during election
of release candidate. Do you know why ?

		Franck
