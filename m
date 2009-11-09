Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 12:36:54 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.145]:16868 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492479AbZKILgs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 12:36:48 +0100
Received: by ey-out-1920.google.com with SMTP id 4so117456eyg.52
        for <multiple recipients>; Mon, 09 Nov 2009 03:36:48 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=VYKYmXNBA3y19ntzeFa0sjdAonwVh69pgf7ICAU0HaM=;
        b=HdvZbsJTy4EsMAMyQ04Jqxpi0jbihDlqwvqXtvwSxxOayzRcDpie8ovYsliXKg9d8h
         TJzGufweiU3pBa21H5F7tQOGOJUHvI+KvGvDi9FTDm0OyzJRd6zFTFMxC3mwDV7cXBPi
         bvX6i2NL2Y/hrzgE4ZL4NPAyJ8bND9vu0lDO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sDUJtzhK4VnQ6UO3hRWq7V14CclNuV1bU+0IbJW9BzjlXYfQycX2qEnnKstzLL61OA
         Nuj2rlzYnNnbmoHdQxXpccKG9ErYU9oEQpMUaN/E0ev34nxbZerzReQAiEfWiEP9pAav
         +0sCs1LemkuCaBHvt3i5fYUZiL8w2yTGCLauw=
Received: by 10.213.2.71 with SMTP id 7mr4059235ebi.68.1257766607946;
        Mon, 09 Nov 2009 03:36:47 -0800 (PST)
Received: from nowhere (ADijon-552-1-106-222.w90-33.abo.wanadoo.fr [90.33.185.222])
        by mx.google.com with ESMTPS id 5sm6123057eyf.15.2009.11.09.03.36.44
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 03:36:46 -0800 (PST)
Received: by nowhere (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128/128 bits))
	fweisbec@gmail.com; Mon,  9 Nov 2009 12:36:52 +0100 (CET)
Date:	Mon, 9 Nov 2009 12:36:50 +0100
From:	Frederic Weisbecker <fweisbec@gmail.com>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
Subject: Re: [PATCH -v6 08/13] tracing: add IRQENTRY_EXIT section for MIPS
Message-ID: <20091109113647.GA5206@nowhere>
References: <cover.1256569489.git.wuzhangjin@gmail.com> <f746f813531a16bd650f9290787c66cbc0cdc34d.1256569489.git.wuzhangjin@gmail.com> <20091109022640.GC13153@nowhere> <1257737468.3451.9.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257737468.3451.9.camel@falcon.domain.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Nov 09, 2009 at 11:31:08AM +0800, Wu Zhangjin wrote:
> Who should I resend this patchset to? you or Steven? If this patchset
> are okay, I will rebase it on the latest tracing/core branch of -tip and
> send the latest version out, and hope you can apply it, otherwise, I
> need to rebase it to the future mainline versions again and again ;) and
> at least, I have tested all of them and their combinations on YeeLoong
> netbook, they work well. of course, more testing report from the other
> MIPS developers are welcome ;)
> 
> Regards,
> 	Wu Zhangjin


You can keep the current Cc list so that we are all uptodate with the
latest state. I don't think you need to rebase against latest tracing/core
as there doesn't seem to be conflicatble changes inside added lately.
The person who is likely to apply it is Steven as he can test it :)

Thanks.
