Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 10:50:55 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:37009 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904081Ab1KDJuu convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2011 10:50:50 +0100
Received: by faaq17 with SMTP id q17so3197382faa.36
        for <multiple recipients>; Fri, 04 Nov 2011 02:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kmARUsjmOr0VwO16bEVSzMQb//EInf3ygbzHhfDWkxE=;
        b=OdKMGGF4WR6z9RmIAL1OR2NkjAvXYQH0e2o0mr+jfEsu+QYncZeYfKHKAvqeU/PunO
         UmYRPKCJdNI3Q4Af38gkWz05VyDxkGp94KxW/KnHw3KIObYzdXN2ZsOId56+wc+QOYqb
         RqcNiLisKDlYpOm5dxHxY1OESce/BuUOkP5W0=
MIME-Version: 1.0
Received: by 10.223.75.150 with SMTP id y22mr22993098faj.29.1320400244762;
 Fri, 04 Nov 2011 02:50:44 -0700 (PDT)
Received: by 10.223.105.141 with HTTP; Fri, 4 Nov 2011 02:50:44 -0700 (PDT)
In-Reply-To: <20111104093222.GA1633@linux-mips.org>
References: <cover.1319364492.git.jonas@southpole.se>
        <04ce50ed7e9e9a949a3c0b447c3aec0a8c6face4.1319364492.git.jonas@southpole.se>
        <20111104093222.GA1633@linux-mips.org>
Date:   Fri, 4 Nov 2011 10:50:44 +0100
Message-ID: <CACM3HyE09_1GTuHUryNzxLdm5uKGdkVwRmxeg4HBp9_mTWjbRA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/8] mips: implement syscall restart generically
From:   Jonas Bonn <jonas.bonn@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jonas Bonn <jonas@southpole.se>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.bonn@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3439

On 4 November 2011 10:32, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> Nice cleanup.
>
> Any reason why you add empty version of syscall_get_arguments and
> syscall_set_version?  A non-functional version that causes a silent
> failure is way worse than something that fails at compile time.

Good point... I'll remove those empty functions for this patch series
and look into doing a proper implementation for them later.

Thanks for the review.

/Jonas
