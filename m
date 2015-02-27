Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 01:51:50 +0100 (CET)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:44926 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007512AbbB0AvsoBgL- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 01:51:48 +0100
Received: by iecar1 with SMTP id ar1so23602515iec.11;
        Thu, 26 Feb 2015 16:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Ek0CPCU04vBPStbV+sn+CfyyYBn7X2oxNzCH8B9dSoU=;
        b=Ha2HdNXCyOQX3Txt/+CYYtZ6lfF5q2Ha/Y6J3rXBiRlh+jsAOSE6+qde+4Rgyw8312
         fnIrtmoRxHkLJ7K6yroMMwNKEs0/diMWJa3HUVQmNM58KSpbC4I6JrAT3EUSlwy6x81Z
         1hh9aEqgYydm+wSPHaMMWUslSPQtepkAAlXrH52fhaagZc/qbE38zdXfLvQzh5YxACzd
         dVw0klKSuv02JuWuwPx1CbzuKTDTLlMhpwyc5bBugcm/egl8s8LeYXgRr/LX1KYhKiLv
         aEQZNXFdWS8cNdFLvCRE7/xDC1G4k9oixSM/SB13KihJuEq/BKb6a7z4ds3Nze/Fl/6+
         B4aw==
X-Received: by 10.43.0.138 with SMTP id nm10mr2899462icb.56.1424998303158;
        Thu, 26 Feb 2015 16:51:43 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id ig15sm307815igb.10.2015.02.26.16.51.42
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 26 Feb 2015 16:51:42 -0800 (PST)
Message-ID: <54EFBF9D.4020004@gmail.com>
Date:   Thu, 26 Feb 2015 16:51:41 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH V7 1/3] MIPS: Rearrange PTE bits into fixed positions.
References: <1424996199-21366-1-git-send-email-Steven.Hill@imgtec.com> <1424996199-21366-2-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1424996199-21366-2-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 02/26/2015 04:16 PM, Steven J. Hill wrote:
> From: "Steven J. Hill" <Steven.Hill@imgtec.com>
>
> This patch rearranges the PTE bits into fixed positions for R2
> and later cores. In the past, the TLB handling code did runtime
> checking of RI/XI and adjusted the shifts and rotates in order
> to fit the largest PFN value into the PTE. The checking now
> occurs when building the TLB handler, thus eliminating those
> checks. These new arrangements also define the largest possible
> PFN value that can fit in the PTE. HUGE page support is only
> available for 64-bit cores. Layouts of the PTE bits are now:
>
>     64-bit, R1 or earlier:     CCC D V G [S H] M A W R P
>     32-bit, R1 or earler:      CCC D V G M A W R P
>     64-bit, R2 or later:       CCC D V G RI/R XI [S H] M A W P
>     32-bit, R2 or later:       CCC D V G RI/R XI M A W P
>

That's not really what I meant in my previous response on the subject.
When I said:

     Why not just use RI for everything, instead of taking up two bits
     to represent a single binary concept?

     For the case where there is no RI hardware active, it is a purely
     software bit and you can easily invert the meaning and just have a
     _PAGE_NO_READ bit.

I envisioned something like:

     64-bit, all revisions:    CCC D V G RI XI [S H] M A W P
     32-bit, all revisions:    CCC D V G RI XI M A W P

Are there enough bits to include XI even if hardware doens't support XI?

David Daney
