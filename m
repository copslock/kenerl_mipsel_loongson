Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 15:42:34 +0100 (CET)
Received: from mail-ot0-x243.google.com ([IPv6:2607:f8b0:4003:c0f::243]:34868
        "EHLO mail-ot0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993418AbdCPOjmWBqT0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Mar 2017 15:39:42 +0100
Received: by mail-ot0-x243.google.com with SMTP id a12so8053223ota.2;
        Thu, 16 Mar 2017 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ON7XzahZwYyRd1mYzVGaU9Zxd4cSFqKqYOV6zFF9dnE=;
        b=ObNCc/D9+Gf5CFPXLiWS5RIwunz/MGC9vBgZNFV2L0/0XehWWcmUxBqlR5qteyXHde
         8qJRvKxcwsyutFddJvATy1AKM2oVeIjR1EQjXgkMWsPKJfw1A9IpI1J3n6qZhQW8MxeA
         SphuYg6W1tMT5LLtFu8MkPhNsmdSiJSF7SV5dgTbYe1F8wo3P5Cre9QZN02+ansVy7MC
         GkSof4+FW9n2c6Mm78sE+EWxfYOJj9sIXBv5XdFiYMvKbiLS16z2VFc0CJpjyjH7TblU
         Fygo91Qp91hajEcKsbiIWYviyZyVmttvoqyKHRE4eatb499WrvJD1+p7Op2SKJ6SmPov
         D8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ON7XzahZwYyRd1mYzVGaU9Zxd4cSFqKqYOV6zFF9dnE=;
        b=Lrq22sbtkWjM4JcgUo8klJRkVOBYd6qg5yMT8OmuERgHPCrYStvkl1mdFzc6okQXzf
         Ulpx3x6QAvC7Nigf0+NOnAX2TrfGdJl1/RuFj7PIlxmSfn54oAvaDlMdG8PqV1EVsra1
         lYKYyAHL2pp/62ICSfHBfNPmfmVRv1VJCBukLfwfaD2UWbHMNt8VC3mBzdcNRfMqmyBh
         axBBOnyTUdWLYdnLSOXdem2D+o0afiEN7UjFRY1euxSCPm1J89sTVTeiR7Sq59KU8Mwm
         onX+PV/Iq2dsIvC+zeE22DoMu/BPNSAHsZ5U4eq52Z7EqeBIlnpxMbgpSyA1Arxb1iAU
         nmpA==
X-Gm-Message-State: AFeK/H3axZRq9UpCPrkNXDfIVr8kuCh/ntjCxA8JEiLBLD1hgecSHNmotzPPkxPzFNDW37XYyduwoFlo6tF3Iw==
X-Received: by 10.202.86.82 with SMTP id k79mr4431731oib.150.1489675176561;
 Thu, 16 Mar 2017 07:39:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.6.42 with HTTP; Thu, 16 Mar 2017 07:39:36 -0700 (PDT)
In-Reply-To: <20170316135959.GC3620@krava>
References: <58b2dc6f.cf4d2e0a.f521.74b3@mx.google.com> <CAK8P3a32nbd6Wv9wCjmUX+E3gpnWkAWwKurP9dkuwyf_oegCgg@mail.gmail.com>
 <20170315072204.GB26837@kroah.com> <CAK8P3a2hmA_f8YZKB=fqpcmeP0wRaq9aEORhVF1kLUWtd0nx6Q@mail.gmail.com>
 <20170316122907.GS12825@kernel.org> <20170316124958.GA3620@krava>
 <CAK8P3a1a3uUCQu=FX5n_cLG+wL-LhreNF8fUyavTn5a-87gXLQ@mail.gmail.com> <20170316135959.GC3620@krava>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Mar 2017 15:39:36 +0100
X-Google-Sender-Auth: -SKL6-z_WwtiCNiFtrbis7RNf44
Message-ID: <CAK8P3a0VCjbVp2Aynq0madWyJ8GCNQD93Fi-M_oy6SkADqKNfQ@mail.gmail.com>
Subject: Re: stable build: 203 builds: 4 failed, 199 passed, 5 errors, 41
 warnings (v4.10.1)
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        kernel-build-reports@lists.linaro.org, linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thu, Mar 16, 2017 at 2:59 PM, Jiri Olsa <jolsa@redhat.com> wrote:
> On Thu, Mar 16, 2017 at 02:44:45PM +0100, Arnd Bergmann wrote:
>> On Thu, Mar 16, 2017 at 1:49 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>> > On Thu, Mar 16, 2017 at 09:29:07AM -0300, Arnaldo Carvalho de Melo wrote:
>> >> Em Wed, Mar 15, 2017 at 02:15:22PM +0100, Arnd Bergmann escreveu:
>> >> > On Wed, Mar 15, 2017 at 8:22 AM, gregkh <gregkh@linuxfoundation.org> wrote:
>> >> > >
>> >> > > All now queued up in the stable trees, thanks.
>> >> >
>> >> > Like 4.9.y it builds clean except for a couple of stack frame size warnings
>> >> > and this one that continues to puzzle me.
>> >> >
>> >> > /bin/sh: 1: /home/buildslave/workspace/kernel-builder/arch/x86/defconfig/allmodconfig+CONFIG_OF=n/label/builder/next/build-x86/tools/objtool//fixdep:
>> >> > Permission denied
>> >>
>> >> Jiri? Josh?
>> >
>> > hum, looks like it imight be related to this fix we did for perf:
>> >   abb26210a395 perf tools: Force fixdep compilation at the start of the build
>> >
>> > it's forcing fixdep to be build as first.. having it as a simple dependency
>> > (which AFAICS is objtool case), the make -jX occasionaly raced on high cpu
>> > servers, and executed unfinished binary, hence the permission fail
>>
>> It's probably another variation of this bug, but the commit you cite got merged
>> into 4.10-rc1, while the problem still persists in mainline (4.11-rc2+).
>
> the problem is in objtool build right? the fix was for perf build

Ah, got it. Yes, that must be it then. I supposed we coul duplicate what you
did for perf in objtool, but a cleaner way would be to generalize it for all of
tools/, right?

      Arnd
