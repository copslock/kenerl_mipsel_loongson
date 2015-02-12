Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2015 05:17:05 +0100 (CET)
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:47529 "EHLO
        resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006154AbbBLERD06veX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Feb 2015 05:17:03 +0100
Received: from resomta-ch2-02v.sys.comcast.net ([69.252.207.98])
        by resqmta-ch2-11v.sys.comcast.net with comcast
        id rGFf1p00427uzMh01GGtbw; Thu, 12 Feb 2015 04:16:53 +0000
Received: from [192.168.1.13] ([69.250.160.75])
        by resomta-ch2-02v.sys.comcast.net with comcast
        id rGGs1p00J1duFqV01GGsWZ; Thu, 12 Feb 2015 04:16:53 +0000
Message-ID: <54DC2928.7070005@gentoo.org>
Date:   Wed, 11 Feb 2015 23:16:40 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
References: <54BCC827.3020806@gentoo.org>
In-Reply-To: <54BCC827.3020806@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1423714613;
        bh=GRpSXh1EiNhj5lL61wmG1ldwTPT7Dg8SRdoAxiTdhfg=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=aZHDSwUNUTG22xYsanga4mGWwuTPE3PGwM8ovYXRAYs+XlkPtd9IjrhRIjEKvaVCm
         pPq2R2Yi8KF7YOQpZxBB775Q33GN0eGxKhSZvIziD1e5SFhw6/ThywcFmWDrzLc7Q1
         CGk2vpXrYQ573YkkWXYzbpWMsNNssKu9jeNvnTwPI0sEK7nq04YbIqic/dzOLPIKdt
         RCsgosGolxArwUBSGXfQLOhOh9s6MC+U0Ebu+RXKK+LPE+fH4r12EtEoBc4/56cjFA
         8jJOgkMpDB7GWHNP3BxDwdRgJSo49E0NBbvgLE2ey+uVRmiZvBxoRqXb0tIJq7WH5g
         5n1RCT9OgzV4w==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 01/19/2015 04:02, Joshua Kinard wrote:
> From: Joshua Kinard <kumba@gentoo.org>
> 
> This is a small patch to display the CPU byteorder that the kernel was compiled
> with in /proc/cpuinfo.
> 
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> ---
>  arch/mips/kernel/proc.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> This patch has been submitted several times prior over the years (I think), but
> I don't recall what, if any, objections there were to it.
> 

[much discussion later]
[snip]

So I assume final consensus is this patch (v1 or v2) isn't acceptable to
reintroduce this feature?  If so, I'll mark it as such in patchwork and just
continue to carry it locally in Gentoo's patchset.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
