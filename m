Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2009 20:35:06 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:61361 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024645AbZE2Te7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 May 2009 20:34:59 +0100
Received: by pzk40 with SMTP id 40so5567345pzk.22
        for <multiple recipients>; Fri, 29 May 2009 12:34:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=pOUQ9hcsIG4bdfPQpugyte1N30ufUSh9rYUKy+rijTk=;
        b=sm907kWH8daXIdmYeF4P6IxE4KXIDm+OzlnC17bIozvMR7GzL3Q8PcJuKiLJAk93ds
         90dn8PlBImWQoLeTg4dSfl4y9VPded0I6PcwhsSBcNwSG5qFmxJpy+mnRzGcwFkScGDs
         YF2XpMhmZ0WWlDjcJWRvSxX2PNByzn9MwJlp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=C0yYbY1qoWFV28KyPAX9g8T+eAWPEVXstp3r32coRqiyqBRVtX+jUHcGfWG4NJOs30
         kv66eWPQcxmSGwBBHLtcYVsTn85Bual9DqAWQ6OMdR7cswz6JFR8KJz2t75za9OJwywK
         kN1/jhoP+cBXq57E5oJLxcmRHVGFeRuXcm2dU=
Received: by 10.115.106.18 with SMTP id i18mr4691274wam.213.1243625691763;
        Fri, 29 May 2009 12:34:51 -0700 (PDT)
Received: from ?192.168.1.100? ([219.246.59.144])
        by mx.google.com with ESMTPS id k21sm2644725waf.59.2009.05.29.12.34.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 12:34:50 -0700 (PDT)
Subject: Re: [loongson-PATCH-v2 23/23] Hibernation Support in mips system
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, yanh@lemote.com,
	philippe@cowpig.ca, r0bertz@gentoo.org, zhangfx@lemote.com,
	loongson-dev@googlegroups.com, der.herr@hofr.at, liujl@lemote.com,
	erwan@thiscow.com
In-Reply-To: <20090530.011259.260978238.anemo@mba.ocn.ne.jp>
References: <cover.1243362545.git.wuzj@lemote.com>
	 <1483a7cb0f587bd329ea3ca8d3af2881afadaf5e.1243362545.git.wuzj@lemote.com>
	 <1243530658.19464.5.camel@falcon>
	 <20090530.011259.260978238.anemo@mba.ocn.ne.jp>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 30 May 2009 03:12:44 +0800
Message-Id: <1243624364.18071.30.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-05-30 at 01:12 +0900, Atsushi Nemoto wrote:
> On Fri, 29 May 2009 01:10:58 +0800, Wu Zhangjin <wuzj@lemote.com> wrote:
> > > +LEAF(swsusp_arch_suspend)
> > [...]
> > > +	PTR_S a0, PT_R4(t0)
> > > +	PTR_S a1, PT_R5(t0)
> > > +	PTR_S a2, PT_R6(t0)
> > 
> > ooh, seems miss:
> > 
> > 	PTR_S a3, PT_R7(t0)
> > 
> > and is there a need to save/restore a4,a5,a6,a7 in 64bit kernel? 
> 
> No.  And I think no need to save/resotre a0 to a3 and v1 too.
> 

Acked.

Thanks!
Wu Zhangjin
