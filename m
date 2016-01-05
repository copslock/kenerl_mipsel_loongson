Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 17:03:56 +0100 (CET)
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36988 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009632AbcAEQDzV8A5e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 17:03:55 +0100
Received: by mail-wm0-f52.google.com with SMTP id f206so36123463wmf.0
        for <linux-mips@linux-mips.org>; Tue, 05 Jan 2016 08:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jpgcMYKUrXnSokKws2cPc8g9vCpoiXmj2f2wLSplA1o=;
        b=Ocx01KacczgluOwjKf3xJcsq72cu5nfkaYdxIK2tc+xH2AMhkZ6R9CdXQkrgcQ61Ti
         nkX7T3Z1gUNrD3ODNc3/c2S6YEkIjPCvFzLCB2hwTRNHCKbiMnJT3o3Mun9Us69p0i4v
         iWSaKvws7l9ek7tQY+zlRVph6w+oOmWu1j+1ejpC7utOIBNsmrt7YL/gejSeLmUWyd5E
         /KO7TCyLVbgBnqANdr3+GMJPSNVDcRRRLR88EymvlQCmeWKf3QX2C3VV/vr+XoEGJuLn
         ukZ+DEm9FPOXUg4mq7gyHNudhVt+qTC/wPEv9rfFCrvgYFtX9vP8ALtUc4k+23V5VmV2
         BRVA==
X-Received: by 10.28.148.82 with SMTP id w79mr5004884wmd.71.1452009830090;
        Tue, 05 Jan 2016 08:03:50 -0800 (PST)
Received: from debian (h249n21-ld-c-a31.ias.bredband.telia.com. [78.70.84.249])
        by smtp.gmail.com with ESMTPSA id q75sm4219595wmd.6.2016.01.05.08.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2016 08:03:49 -0800 (PST)
Date:   Tue, 5 Jan 2016 17:03:45 +0100
From:   Rabin Vincent <rabin@rab.in>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, daniel@iogearbox.net,
        ast@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: filter: make JITs zero A for SKF_AD_ALU_XOR_X
Message-ID: <20160105160345.GA3951@debian>
References: <1452007387-626-1-git-send-email-rabin@rab.in>
 <1452009645.8255.96.camel@edumazet-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452009645.8255.96.camel@edumazet-glaptop2.roam.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <rabin.vincent@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rabin@rab.in
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

On Tue, Jan 05, 2016 at 08:00:45AM -0800, Eric Dumazet wrote:
> On Tue, 2016-01-05 at 16:23 +0100, Rabin Vincent wrote:
> > The SKF_AD_ALU_XOR_X ancillary is not like the other ancillary data
> > instructions since it XORs A with X while all the others replace A with
> > some loaded value.  All the BPF JITs fail to clear A if this is used as
> > the first instruction in a filter.
> 
> Is x86_64 part of this 'All' subset ? ;)

No, because it's an eBPF JIT.
