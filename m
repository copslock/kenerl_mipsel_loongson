Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Dec 2015 17:18:51 +0100 (CET)
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36009 "EHLO
        mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008993AbbL1QSrDu4Hj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Dec 2015 17:18:47 +0100
Received: by mail-yk0-f176.google.com with SMTP id v14so14195396ykd.3;
        Mon, 28 Dec 2015 08:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BXbBrfIaRDLvO47il9Vs28GGfm4o06kLJw5EDEr4iD8=;
        b=USOjGjqxOSE4NW5nlo1/J32MrTe1O/ZHeeWoiiT/kpFiL2ldWzNKFD8SnTpytWLjj1
         +Q9+gZkgU9cV9UceddmimE4g5BrNxqUiQ5UbvJJ2ovNrdbDZcK28mbWTICChAbh8UBfr
         DgPPZ0Hftr1gtAfks+6ibFlO9lC6TmlWf7D6bQvlOwZSpqLcNBjr7DLT4CoEjKmwwK36
         gxTpZOvLfdA32ISbRWherOOBozMXWlg/Fao7agYKANHewSns7CFQBqxYm/B390WxYU4x
         d0QrEYe3grNz8Bh+TZmuYpJ6AGX5j3azeKdizbb/UCyYjzLQZoArz0ii9kbD6bLDPdQ0
         aFFQ==
X-Received: by 10.129.57.69 with SMTP id g66mr21387224ywa.176.1451319521390;
        Mon, 28 Dec 2015 08:18:41 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::d:d535])
        by smtp.gmail.com with ESMTPSA id 193sm18953379ywe.22.2015.12.28.08.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Dec 2015 08:18:40 -0800 (PST)
Date:   Mon, 28 Dec 2015 11:18:39 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Build regressions/improvements in v4.4-rc7
Message-ID: <20151228161839.GS5003@mtj.duckdns.org>
References: <1451305281-3911-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWnSERAHcxDV47FRY1Sz6XJku72xRPb1cGig7sSF8nf4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWnSERAHcxDV47FRY1Sz6XJku72xRPb1cGig7sSF8nf4A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
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

On Mon, Dec 28, 2015 at 01:29:18PM +0100, Geert Uytterhoeven wrote:
> On Mon, Dec 28, 2015 at 1:21 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v4.4-rc7[1] to v4.4-rc6[3], the summaries are:
> >   - build errors: +14/-3
> 
>   + /home/kisskb/slave/src/include/linux/kqueue.h: error:
> dereferencing type-punned pointer will break strict-aliasing rules
> [-Werror=strict-aliasing]:  => 186:2

kqueue.h?

-- 
tejun
