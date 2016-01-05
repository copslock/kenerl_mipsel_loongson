Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 18:43:35 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35150 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009955AbcAERnU3Xfmm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 18:43:20 +0100
Received: by mail-pa0-f46.google.com with SMTP id ho8so2080686pac.2
        for <linux-mips@linux-mips.org>; Tue, 05 Jan 2016 09:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kD/9/yv32gCrI40XvCfUJ0X+Ts1N4aJe0UFPd8L8L20=;
        b=uE8PFnxvr+9APnGsRrTmkpbsNFElU8MPbx5f8J/ihQ19F6RZyKDT0y7WScEYt7EN2Q
         q5cPQWh4Ff8p3BV58O/kro/EsFUv2avl+1vLWMZ2ktvWat6m9J7f1EPGaKqY8XS+DZON
         YHg6UVSHkcewBZ6wasj4nkzenh5bJHhCmwM3xC968UNiu/zjEpgOkSdyVCObAY1Yii9M
         Cqwjgk47seNMqFwCujm4WInVpY2CuXPXROXa2FGxTCWz6eRc9R3R/Dspq6PODJfbJo8q
         qjofkY4qJpLIrzVrjmZd214PHDUDKlok5ymnSGZ7/KRDmDNiUDdSndbA6eKGiErhtvXb
         b2Qg==
X-Received: by 10.66.218.225 with SMTP id pj1mr132391888pac.40.1452015794368;
        Tue, 05 Jan 2016 09:43:14 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:200::b:e6be])
        by smtp.gmail.com with ESMTPSA id w23sm106632527pfa.24.2016.01.05.09.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2016 09:43:13 -0800 (PST)
Date:   Tue, 5 Jan 2016 09:43:10 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Rabin Vincent <rabin@rab.in>, davem@davemloft.net,
        netdev@vger.kernel.org, ast@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: filter: make JITs zero A for SKF_AD_ALU_XOR_X
Message-ID: <20160105174309.GA83548@ast-mbp.thefacebook.com>
References: <1452007387-626-1-git-send-email-rabin@rab.in>
 <568BF11F.1060507@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568BF11F.1060507@iogearbox.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <alexei.starovoitov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexei.starovoitov@gmail.com
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

On Tue, Jan 05, 2016 at 05:36:47PM +0100, Daniel Borkmann wrote:
> On 01/05/2016 04:23 PM, Rabin Vincent wrote:
> >The SKF_AD_ALU_XOR_X ancillary is not like the other ancillary data
> >instructions since it XORs A with X while all the others replace A with
> >some loaded value.  All the BPF JITs fail to clear A if this is used as
> >the first instruction in a filter.  This was found using american fuzzy
> >lop.
> >
> >Add a helper to determine if A needs to be cleared given the first
> >instruction in a filter, and use this in the JITs.  Except for ARM, the
> >rest have only been compile-tested.
> >
> >Fixes: 3480593131e0 ("net: filter: get rid of BPF_S_* enum")
> >Signed-off-by: Rabin Vincent <rabin@rab.in>
> 
> Excellent catch, thanks a lot! The fix looks good to me and should
> go to -net tree.
> 
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

good catch indeed.
Classic bpf jits didn't have much love. Great to see this work.

Acked-by: Alexei Starovoitov <ast@kernel.org>
