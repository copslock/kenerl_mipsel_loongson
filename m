Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2012 04:17:58 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:55902 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903617Ab2FDCRy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jun 2012 04:17:54 +0200
Received: by wibhm14 with SMTP id hm14so2104748wib.6
        for <multiple recipients>; Sun, 03 Jun 2012 19:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kzvaYxuJPMN1bPhqJlosFC1b15P1eydXXGWWeqlcfmo=;
        b=ijL6vdCCB69iQB185wQ+PqtuYq2TCvQqVa+Wti/kzRj3tnJY6QvmMGwyoRSMKBeoaM
         uoaJRirOV2aij4lxzokHIYm3kdzMM/wSXUEDaVbFFIr3zUXj7F/so58mGo0AYLhyyu6Y
         elNdYoWYDJiq7lSHTpUzvzg9eWaosrFhskb80lkvEtgdTpfXfL/4FqC18Ypk0mgM3PdY
         aVfq6KCsBeacOfcI2bL1a4miCq26J2+67zaIhSgoXQ211PXyyGxNak2BYkZcf+zzbKhv
         ztOAVzZvfZD82NJ356SOw+ChD0dT29YW8TaedJ0T3H1N8uExnhGJffen3WA8HXbsWMRX
         5JPg==
Received: by 10.216.202.160 with SMTP id d32mr6679026weo.147.1338776268645;
        Sun, 03 Jun 2012 19:17:48 -0700 (PDT)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id bn9sm16974537wib.5.2012.06.03.19.17.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jun 2012 19:17:45 -0700 (PDT)
Date:   Mon, 4 Jun 2012 10:17:17 +0800
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc:     tglx@linutronix.de, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au,
        mingo@kernel.org, akpm@linux-foundation.org,
        vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com,
        Ralf Baechle <ralf@linux-mips.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>,
        David Howells <dhowells@redhat.com>,
        Arun Sharma <asharma@fb.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 10/27] mips, smpboot: Use generic SMP booting
 infrastructure
Message-ID: <20120604021717.GA26319@zhy>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
 <20120601091226.31979.62223.stgit@srivatsabhat.in.ibm.com>
 <20120603082507.GA16829@zhy>
 <4FCB4F00.8080202@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4FCB4F00.8080202@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Jun 03, 2012 at 05:18:16PM +0530, Srivatsa S. Bhat wrote:
> Yes, I noticed that while writing the patch. But then, I thought of cleaning
> up the hundreds of callin/callout/commenced maps in various architectures and
> bringing them out into core code in a later series, and clean this up at that time..
> I didn't want to do too many invasive changes all at one-shot.

OK.

> But I guess for this particular case of mips, I can get rid of the wait for
> cpu_callin_map in this patchset itself. I'll update this patch with that change.

:-)

> So what is the status of those patches? Has anyone picked them up?
> 
> I could rebase this patch on top of yours, or better yet, if your
> patches haven't been picked up yet, I could include them in this
> patchset itself to avoid too many dependencies on external patches.
> 
> What do you say?

Ralf has pushed it to http://git.linux-mips.org/?p=ralf/linux.git;a=summary

I guess you can see it soon.

Thanks,
Yong
