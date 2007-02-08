Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 09:18:05 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.235]:18562 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037872AbXBHJSB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Feb 2007 09:18:01 +0000
Received: by qb-out-0506.google.com with SMTP id e12so44798qba
        for <linux-mips@linux-mips.org>; Thu, 08 Feb 2007 01:17:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dygJ1HJOXEd98Hn6USdm8nRShXZa9tigDmZhqWFU+wTXApTed3hF0uyVu+Q9INRk51Njw7VdgYvR7I1By6lsFK+TlmZzE3ix8uuWnjBCFawc6dYFhThpOpRKsZesimxGCg4f+I0CdihFgQemDMyWAmQSOP4jUEQC6GJBpgVmjOw=
Received: by 10.115.95.1 with SMTP id x1mr2508581wal.1170926219452;
        Thu, 08 Feb 2007 01:16:59 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Thu, 8 Feb 2007 01:16:59 -0800 (PST)
Message-ID: <cda58cb80702080116j1d398053q666aa087e0b578ea@mail.gmail.com>
Date:	Thu, 8 Feb 2007 10:16:59 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 0/10] Clean up signal code [take #3]
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <cda58cb80702080055w5b052319u7f49281aa55928ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11706854683935-git-send-email-fbuihuu@gmail.com>
	 <20070208.010430.58789357.anemo@mba.ocn.ne.jp>
	 <cda58cb80702080055w5b052319u7f49281aa55928ea@mail.gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/8/07, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Hi Atsushi
>
> Thanks for you review !
>
> On 2/7/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > # Though [PATCH 6/10] failed due to recent whitespace cleanup ...
> >
>
> I can rebase it if needed,
>
> > I hope this patchset applied before updating my fp_context patches.
>
> yeah I hope too...
>

BTW, did you have time to try it on a 64-bits kernel ?

Thanks
-- 
               Franck
