Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 22:54:48 +0100 (CET)
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33679 "EHLO
        mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007079AbbCDVyr3m1-6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 22:54:47 +0100
Received: by wghb13 with SMTP id b13so49564029wgh.0;
        Wed, 04 Mar 2015 13:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lUpf/gaW9Ca3Z5n2UaICOdnfr/DcEUzrSkWlnYj51hg=;
        b=Cjem9B31G6Yu0BPF7YwTLPTScUAOfJNgjIhh7R7TIIFPeXf787UC89z6gOPjUiNllE
         4E7H+IVbmgo1mG+LSacw0Sv6U8cmllWvEvHClGVCilERcx5lghcOje/urEIBfSpJFeDe
         wSOtlv7J907Cu/DDfn9x6bhYuiSjtFjn792O4XMxuInYl6W4GF/Qa5pMZhp5Tg5TMYAf
         tj1yHseCfrwteC25prR4ETh8LbMZJ0/34E/tWNI9FcKCXex3qcfoIpGSVAtLh0cUTM7/
         5cpc4j5uf56tRoxWVVeRkH20RRpT1nwgoI2DwwmlXD4CdmcicUJsEp4qyfaupi30fw0I
         czXQ==
X-Received: by 10.180.90.145 with SMTP id bw17mr4877243wib.80.1425506082788;
        Wed, 04 Mar 2015 13:54:42 -0800 (PST)
Received: from gmail.com (540334ED.catv.pool.telekom.hu. [84.3.52.237])
        by mx.google.com with ESMTPSA id a13sm7691493wjx.30.2015.03.04.13.54.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2015 13:54:40 -0800 (PST)
Date:   Wed, 4 Mar 2015 22:54:37 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Ismael Ripoll <iripoll@upv.es>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "David A. Long" <dave.long@linaro.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Arun Chandran <achandran@mvista.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Min-Hua Chen <orca.chen@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Borislav Petkov <bp@suse.de>,
        Jan-Simon =?iso-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/10] split ET_DYN ASLR from mmap ASLR
Message-ID: <20150304215437.GA22254@gmail.com>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425503454-7531-1-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


* Kees Cook <keescook@chromium.org> wrote:

> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
> ASLR from mmap ASLR, as already done on s390. The architectures
> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
> and x86), have their various forms of arch_mmap_rnd() made available
> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
> arch_randomize_brk() is collapsed as well.
> 
> This is an alternative to the solutions in:
> https://lkml.org/lkml/2015/2/23/442
> 
> I've been able to test x86 and arm, and the buildbot (so far) seems
> happy with building the rest.

Ok, this looks really good - for all patches:

   Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
