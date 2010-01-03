Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 19:32:35 +0100 (CET)
Received: from mail-fx0-f211.google.com ([209.85.220.211]:38831 "EHLO
        mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492757Ab0ACSc2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2010 19:32:28 +0100
Received: by fxm3 with SMTP id 3so5202140fxm.24
        for <multiple recipients>; Sun, 03 Jan 2010 10:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=PUK0l7B++U34esseWgBlztdJWNai2kr87JxiqAdWpgg=;
        b=Kxcs0bcYpffb3vFx9hnc/iUWbF7/Wh8eAIVSZzTg7ixk9Z9abCctYRFbewmyOOxHSB
         /5ZNiMQ6BNWQ/PpCLE14fetGDJpu98e9Gj2Mi+YPqYfoJ2rqvgJc33dQmxiV4Y5U1Fi0
         OIju170ONk7ekT6wVa6GutTnKetiUu62alOX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=XGFRGLmpCmo7L2ultbgRX+s0Y4DwoKJOqCtl8k4AX9j4k+VBliBVwDfwLfIUVhDrQa
         IIUQ/pLlcK1Xq0S80h6l1qg+PCZpkhkUio4DNoGFbDSzeU4sdgUfJvVCiuspvucZlJF2
         HwIhdltimWqGAr6CuCPcOsQ6FQ6GlHai7adzA=
Received: by 10.223.4.220 with SMTP id 28mr16018151fas.18.1262543540486;
        Sun, 03 Jan 2010 10:32:20 -0800 (PST)
Received: from rin.localnet ([72.14.240.164])
        by mx.google.com with ESMTPS id d13sm25177818fka.47.2010.01.03.10.32.16
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Jan 2010 10:32:18 -0800 (PST)
From:   Marek Vasut <marek.vasut@gmail.com>
Organization: Hack&Dev
To:     linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] stack2core: show stack message and convert it to core file when kernel die
Date:   Sun, 3 Jan 2010 19:32:11 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-1-amd64; KDE/4.3.2; x86_64; ; )
Cc:     "Russell King - ARM Linux" <linux@arm.linux.org.uk>,
        Hui Zhu <teawater@gmail.com>, linux-mips@linux-mips.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Coly Li <coly.li@suse.de>,
        Paul Gortmaker <Paul.Gortmaker@windriver.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        David Daney <ddaney@caviumnetworks.com>,
        Chris Dearman <chris@mips.com>, Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        saeed bishara <saeed.bishara@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Brian Gerst <brgerst@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Greg Kroah-Hartman" <gregkh@suse.de>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com> <daef60381001030939r60315c1dy56025a041a8ee758@mail.gmail.com> <20100103174737.GD21156@n2100.arm.linux.org.uk>
In-Reply-To: <20100103174737.GD21156@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201001031932.11210.marek.vasut@gmail.com>
X-archive-position: 25485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marek.vasut@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1973

Dne Ne 3. ledna 2010 18:47:37 Russell King - ARM Linux napsal(a):
> On Mon, Jan 04, 2010 at 01:39:44AM +0800, Hui Zhu wrote:
> > scripts/markup_oops.pl just support x86?
> > s2c support x86, x8664, arm, mips, mips64.
> 
> I'm sure there's patches around to make it work on ARM, or if not,
> there soon will be.

And if there are not, that's the place you should focus yourself on rather than 
duplicating work ...

> There's certainly patches around at the moment
> to make scripts/decodecode work on ARM.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
