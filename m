Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jul 2010 05:32:49 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:36973 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490955Ab0GJDcp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jul 2010 05:32:45 +0200
Received: by pxi13 with SMTP id 13so1289545pxi.36
        for <multiple recipients>; Fri, 09 Jul 2010 20:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=x4k/qK+vUN55nxvyXM+jfQ6+eTRalmubPQf6B/40uMk=;
        b=TTSo47QHR4NXovQUojOAjeUs6K17Ywi199sG90O6C5KUq0u9eAUQF1pUCDNC/MqY8G
         0+Z55P+OVIJaWrUA4HjXrs4X/rb0j/LSR8GCI7AYgBQf+WAMYJqmj310Pjcd3lDj4Ann
         VInuMgrcDdAAG2Tk7Vu7oCViYJRq0Kc5oXFhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=WFAAVmMVr88wopmvT29kJUCIUqb0GT/qNIudE6EL/NSUOPolHrsUJ+n35PKzjMKseN
         WqD8C4P46ZQHjbfPokpEa6uiaao6ARBj0MyLWSPma5LWeZ32/wZOwc84eE9eD2UDS+zz
         n/N4eHMuPfeCxISPVx3X8dBhJ8IRbto9uPUHs=
Received: by 10.142.148.2 with SMTP id v2mr7456717wfd.115.1278732756550;
        Fri, 09 Jul 2010 20:32:36 -0700 (PDT)
Received: from [192.168.0.106] ([182.18.29.11])
        by mx.google.com with ESMTPS id z1sm1842990wfd.15.2010.07.09.20.32.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 20:32:35 -0700 (PDT)
Subject: Re: [PATCH] tracing: recordmcount.pl: Fix $mcount_regex for MIPS.
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     rostedt@goodmis.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Li Hong <lihong.hi@gmail.com>, Ingo Molnar <mingo@elte.hu>,
        Matt Fleming <matt@console-pimps.org>,
        Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <1278721562.1537.169.camel@gandalf.stny.rr.com>
References: <1278712325-12050-1-git-send-email-ddaney@caviumnetworks.com>
         <1278721562.1537.169.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sat, 10 Jul 2010 11:32:30 +0800
Message-ID: <1278732750.4750.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2010-07-09 at 20:26 -0400, Steven Rostedt wrote:
> 
> I'd like to get an Acked-by from Ralf and Wu before pulling this.
> 

It is ok for me ;)

Acked-by: Wu Zhangjin <wuzhangjin@gmail.com>

Regards,
	Wu Zhangjin
