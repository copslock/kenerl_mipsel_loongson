Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Jun 2013 13:51:31 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:55010 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822672Ab3FLLvQnzX-O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Jun 2013 13:51:16 +0200
Received: by mail-wi0-f171.google.com with SMTP id hj3so383915wib.10
        for <multiple recipients>; Wed, 12 Jun 2013 04:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=GKfMKfGsXNWvXyuIhFK0/MvkY0zwAh1gTwPK76WB/0Q=;
        b=rqNSuBm4/elOOu3RHA7DMBkBRwT7onmZ+dzraS+nnN/ZnXG8nw0UPGLApef6fM3HAF
         bH9y6ze+eEOZei7TBindbpISca/QNzF/rrd75Rpswhqv7oAAW+OIGuHuG0lg48ATK5FC
         RBXKkI6yAl8WGKZOv1Cmw1IoA5bfRMjJTxcBrnKBykHKgqsH/E8zh6PeBH3z29sZ3alA
         Xx+prY3nHtHZkPAWnZJt9LiplrEXlqLSGUo+AUjAuBhB3K/i1kNTWZ5f+peiqFnMOC3q
         DxWBb8tHrE2BbT+jJu/DxftMQkW8iI8WwZHJtQ/twwsJJhluZjgzk74dH/ZeUte4Tx2q
         AZ1g==
X-Received: by 10.181.13.112 with SMTP id ex16mr4188475wid.28.1371037871165;
 Wed, 12 Jun 2013 04:51:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.136.115 with HTTP; Wed, 12 Jun 2013 04:50:31 -0700 (PDT)
In-Reply-To: <20130612112009.GA7422@linux-mips.org>
References: <1370944336-13703-1-git-send-email-markos.chandras@imgtec.com>
 <20130611154129.GD13126@linux-mips.org> <20130612112009.GA7422@linux-mips.org>
From:   Markos Chandras <hwoarang@gentoo.org>
Date:   Wed, 12 Jun 2013 12:50:31 +0100
X-Google-Sender-Auth: ukzI-nDwog9fEcnu94Lsma-_9hw
Message-ID: <CAG2jQ8i5Sp1qp+6X+PkSugQXUtADm5xPCf4+V5f6=H1A=2NBVQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Kconfig: Set default value for the "Kernel code model"
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Michal Marek <mmarek@suse.cz>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <markos.chandras@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hwoarang@gentoo.org
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

On 12 June 2013 12:20, Ralf Baechle <ralf@linux-mips.org> wrote:
> Here's a simplified test case:
>
> < --------- bite here --------- >
> choice
>         prompt "choice 1"
>
> config FOO1
>         bool "foo 1"
>
> config FOO2
>         bool "foo 2"
> endchoice
>
> choice
>         prompt "frob"
>
> config BAR
>         bool "bar"
>         depends on FOO2
>
> endchoice
> < --------- bite here --------- >
>
> Save this to a file, then run:
>
>   scripts/kconfig/conf --randconfig /tmp/xxx && cat .config
>
> There will be two possible variants for generated .config files:
>
> < --------- Variant 1 --------- >
> CONFIG_FOO1=y
> # CONFIG_FOO2 is not set
> < --------- Variant 2 --------- >
> # CONFIG_FOO1 is not set
> # CONFIG_FOO2 is not set
> < --------- End       --------- >
>
> The intended third outcome which would be
> < --------- doesn't happen ---- >
> # CONFIG_FOO1 is not set
> CONFIG_FOO2=y
> < --------- End --------------- >
>
> never gets generated.
>
> Pretty much any tempering with this test case will change the behaviour.
> For example removing the "depends on FOO2" line will result in the
> behaviour of either CONFIG_FOO1 or CONFIG_FOO2 being set to y but never
> none or both.  Other minor changes might result in both symbols getting
> set.
>
>   Ralf
>

Thanks for the testcase Ralf. My understanding is that if the 'choice'
symbol is available (meaning, all the dependencies are satisfied),
then one of the possible choices should always be selected. So
variant2 in the previous example seems wrong behavior to me.

--
Regards,
Markos Chandras - Gentoo Linux Developer
http://dev.gentoo.org/~hwoarang
