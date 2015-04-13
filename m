Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Apr 2015 19:08:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12609 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011532AbbDMRIZOwWOu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Apr 2015 19:08:25 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 54C08B9178C77;
        Mon, 13 Apr 2015 18:08:17 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 13 Apr
 2015 18:08:20 +0100
Received: from [192.168.159.37] (192.168.159.37) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 13 Apr
 2015 10:08:18 -0700
Message-ID: <552BF7F8.5020008@imgtec.com>
Date:   Mon, 13 Apr 2015 12:08:08 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Lars Persson <lars.persson@axis.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fix HIGHMEM crash in __update_cache().
References: <1428672084-20676-1-git-send-email-larper@axis.com> <20150410134711.GC21107@linux-mips.org> <675481A1-B1B2-47BF-9AF9-2E7773497FEA@axis.com>
In-Reply-To: <675481A1-B1B2-47BF-9AF9-2E7773497FEA@axis.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.37]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

On 04/10/2015 09:31 AM, Lars Persson wrote:
> Ralf,
> 
> I came to think that also non-executable mappings for highmem pages
> could reach the flushing code in __update_cache() and trigger an
> OOPS.
> 
> Until the highmem patches are merged we should block highmem pages in
> __update_cache().  Could you add this to the patch ?
> 
> Sent from my iPhone
> 
Did you look at the patches:

   http://patchwork.linux-mips.org/patch/9284/
   http://patchwork.linux-mips.org/patch/9285/

Your patch seems rather similar to what is found in these. I have been
trying to get these accepted, but so far no luck.

Steve
