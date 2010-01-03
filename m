Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 18:40:26 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:56063 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493105Ab0ACRkR convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jan 2010 18:40:17 +0100
Received: by pwj1 with SMTP id 1so9107234pwj.24
        for <multiple recipients>; Sun, 03 Jan 2010 09:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=voXcGt0v4aMmF1zyCbVZ635SaPxUjYCO+cFrLElCLw0=;
        b=qZDxRdppzX4InLlhbFKrGeotTldxclCYrYwDRzUKD44mdZBQSghNiC9vWzyFRZdqjj
         OVMUjsDaGaQDVB267H8wzWhGzLXvmsAAa+va/3wk+T1ZBDSSi7jvqzHouOZiFUAPRID/
         5mN+PGoQ+RodvbkbnZ5UJI4KH7TW6ro9z7GMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nKnqBUZK1ZBb8lJTeXd84eD9ZB+ne1pIdbrD53JcGy+ehO4sKVCRtRF2eaSu+nrmeF
         wcZAuVLGtc4FyAOCyHNK+/S0rafaEvVXBGouAgxKkAs2hBkaAXFKu/1rl32wmQzNYNXP
         VAK8IPc46sxGqm5DS3NsW5verpaGCJ3TMAB7E=
MIME-Version: 1.0
Received: by 10.143.25.9 with SMTP id c9mr204169wfj.7.1262540404090; Sun, 03 
        Jan 2010 09:40:04 -0800 (PST)
In-Reply-To: <20100103092608.0a04c664@infradead.org>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com> 
        <20100103160313.GA21156@n2100.arm.linux.org.uk> <daef60381001030830u176c0cfavbb31358a2b42ed60@mail.gmail.com> 
        <20100103164414.GB21156@n2100.arm.linux.org.uk> <daef60381001030855o3a39c3fdr879e2634fb85c491@mail.gmail.com> 
        <20100103092608.0a04c664@infradead.org>
From:   Hui Zhu <teawater@gmail.com>
Date:   Mon, 4 Jan 2010 01:39:44 +0800
Message-ID: <daef60381001030939r60315c1dy56025a041a8ee758@mail.gmail.com>
Subject: Re: [PATCH] stack2core: show stack message and convert it to core 
        file when kernel die
To:     Arjan van de Ven <arjan@infradead.org>
Cc:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        saeed bishara <saeed.bishara@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        Chris Dearman <chris@mips.com>,
        Paul Gortmaker <Paul.Gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Brian Gerst <brgerst@gmail.com>, Tejun Heo <tj@kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Coly Li <coly.li@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 25483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: teawater@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1964

scripts/markup_oops.pl just support x86?
s2c support x86, x8664, arm, mips, mips64.

Thanks,
Hui

On Mon, Jan 4, 2010 at 01:26, Arjan van de Ven <arjan@infradead.org> wrote:
> On Mon, 4 Jan 2010 00:55:04 +0800
> Hui Zhu <teawater@gmail.com> wrote:
>>
>> It show which line make kernel die.
>>
>
> similar to scripts/markup_oops.pl already does ?
>
>
> --
> Arjan van de Ven        Intel Open Source Technology Centre
> For development, discussion and tips for power savings,
> visit http://www.lesswatts.org
>
