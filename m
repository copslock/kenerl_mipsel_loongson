Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Mar 2015 23:22:08 +0100 (CET)
Received: from mail-vc0-f178.google.com ([209.85.220.178]:52730 "EHLO
        mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007833AbbCBWWHQtGqB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Mar 2015 23:22:07 +0100
Received: by mail-vc0-f178.google.com with SMTP id hq11so11972781vcb.9
        for <linux-mips@linux-mips.org>; Mon, 02 Mar 2015 14:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=A5XbaW0GAdKpnMKvFCelxvKod79KN9g44pbpXoQcpM8=;
        b=Jy3qomAjwGW2yGExNKR2Rj9JRdbIcTbeJ3+ViS0fU9C0lQK/mpEdQnRK6dFDdseglV
         dMXK/Ih0+bs5fM94eWfJ5SK6Jm7NhxyKvl5J4PlkX88XbPpi0VmCdga/c6V9Oqx8tTRI
         BORwFryJxPW9rhJjLpgxC2g8VRNjfYEoGtvWvJ84uc/IqnbnpwU6GKkS2bsr1Ug4F5kH
         pd+OSpjV5BVuBcJJ3Jvdf4IgRRwrVnidA2UNhGxZRMMDLjScZootluZzLVVLPukjWNOA
         kpSsD3s3UHVMONxsCWEoOKOdGINosstV2cW3AS1qKs4t0z4gdVjLhsRFnewkn0Aerfr+
         0yNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=A5XbaW0GAdKpnMKvFCelxvKod79KN9g44pbpXoQcpM8=;
        b=bFJRDJK0kSjlyAG2Pu1N7YzRSsbBgpnTrDAOK7aQ1Z6WJbGf60a7HnmXdU9mTOF33k
         lcLE/4MTvcreQDSmFG4hz1RjH2iA/SkLXue2hbLVSi/0o6ParZgeOz/sABHh+iWk+OVH
         SCInghAYV+V7zTfQFI3Pe67zcX0RgNVhi0i+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=A5XbaW0GAdKpnMKvFCelxvKod79KN9g44pbpXoQcpM8=;
        b=OdXZhmyZuSSty6J9J3W4vtGsn76USgBX1s4IwHMBeQC3pE7rj+OSqcUfd5xBnLMp+w
         M24Jo5NS+35tZwaAL6ViMk9dxxGVwsTncgIwDWyAmdPgnShAkX49ciXBXTX+AMMEqaL4
         sTUjs0pWf1NUtGkNmRs2JJ9amgOx41o3pqwuR+zdN1TviD9MjIG2ualL09KVbMLuSdv0
         U+38uCrBBIEnYbPRQGV3uqlDQJYijIfotfa5TcCJp8/hJ5h3X/kLpocqm7A2LPw6k3wS
         m3D2InT8oGd9B1ovAKf64QN/ZpQQCPE8+XNIKWURD2WWixdjeifkYX/4Nl9jRfl2dSF2
         9tVw==
X-Gm-Message-State: ALoCoQnbFWlg81S4vCh3EAnczvKiPRChAtsH+IJQkRsnEgfUUt+vYyoYBKUOT9LfGfVGXmV1UbLq
MIME-Version: 1.0
X-Received: by 10.53.1.7 with SMTP id bc7mr26461524vdd.40.1425334920656; Mon,
 02 Mar 2015 14:22:00 -0800 (PST)
Received: by 10.52.116.135 with HTTP; Mon, 2 Mar 2015 14:22:00 -0800 (PST)
In-Reply-To: <20150302132657.5507742399620e70dd0a3926@linux-foundation.org>
References: <1425006434-3106-1-git-send-email-keescook@chromium.org>
        <20150302132657.5507742399620e70dd0a3926@linux-foundation.org>
Date:   Mon, 2 Mar 2015 14:22:00 -0800
X-Google-Sender-Auth: L7q41VOUeIUQkrMH_Ro2AI10mZo
Message-ID: <CAGXu5j+qOntXiF_zzW-+fGWeU-tBxwSF2UVsLm5D6brNEf-XCw@mail.gmail.com>
Subject: Re: [PATCH 0/5] split ET_DYN ASLR from mmap ASLR
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "x86@kernel.org" <x86@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "David A. Long" <dave.long@linaro.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Arun Chandran <achandran@mvista.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Min-Hua Chen <orca.chen@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Behan Webster <behanw@converseincode.com>,
        Ismael Ripoll <iripoll@upv.es>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <dl9pf@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Mon, Mar 2, 2015 at 1:26 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 26 Feb 2015 19:07:09 -0800 Kees Cook <keescook@chromium.org> wrote:
>
>> This separates ET_DYN ASLR from mmap ASLR, as already done on s390. The
>> various architectures that are already randomizing mmap (arm, arm64, mips,
>> powerpc, s390, and x86), have their various forms of arch_mmap_rnd()
>> made available via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these
>> architectures, arch_randomize_brk() is collapsed as well.
>>
>> This is an alternative to the solutions in:
>> https://lkml.org/lkml/2015/2/23/442
>
> "504 Gateway Time-out"
>
> Hector's original patch had very useful descriptions of the bug, why it
> occurred, how it was exploited it and how the patch fixes it.
>
> Your changelogs contain none of this and can be summarized as "randomly
> churn code around for no apparent reason".
>
> Wanna try again?  I guess the [0/5] and [4/5] changelogs are the ones
> to fix.

Ah, yes, absolutely. I will resend.

-Kees

-- 
Kees Cook
Chrome OS Security
