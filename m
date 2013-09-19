Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 18:37:59 +0200 (CEST)
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59800 "EHLO
        smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6832656Ab3ISQhxoHzoe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Sep 2013 18:37:53 +0200
Received: from smtp.pobox.com (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9642F42B53;
        Thu, 19 Sep 2013 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AuHW/s+tAUyCoTXvCK6pvXSMNKI=; b=VtrFl2
        1M3lSYfV0N9XMdNnr3AP8pXcp0N0gILzaE2YsvLZ2BM0vpK9xJECTm1jTPgrYpwI
        w51KFeN0XUajb+SoDRdiQVvgdSemCt2w0vuaSEAzuHTaPAO8Wy7Ul8vKhs9nFMCr
        1uUIRh1YZey82fnj2P26vXxv8Tteu2V6wbtmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vQSBaCat86G2GvYT6Q6VVwSgvHkNSpoc
        KiYHzoXMP5p77DieMfInR1e+1+hEgY2S+P2CqHIf1XONQqImE8+sWyhEZXn/cslu
        3g4EN5ZyqPMQQGo8KahwTVeggrUNX+EEuEXjSb9QKuD2vmmtdpsHBYFIFKi7qFip
        yCPpUhR3vf8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A0D642B52;
        Thu, 19 Sep 2013 16:37:44 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D393C42B50;
        Thu, 19 Sep 2013 16:37:43 +0000 (UTC)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree@vger.kernel.org, git@vger.kernel.org,
        steven.hill@imgtec.com, mmarek@suse.cz, swarren@nvidia.com,
        linux-mips@linux-mips.org, linux-kbuild@vger.kernel.org,
        james.hogan@imgtec.com
Subject: Re: git issue / [PATCH] MIPS: fix invalid symbolic link file
References: <1379596148-32520-1-git-send-email-maddy@linux.vnet.ibm.com>
        <20130919133920.GA22468@linux-mips.org>
Date:   Thu, 19 Sep 2013 09:37:41 -0700
In-Reply-To: <20130919133920.GA22468@linux-mips.org> (Ralf Baechle's message
        of "Thu, 19 Sep 2013 15:39:20 +0200")
Message-ID: <xmqqsix0u5re.fsf@gitster.dls.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID: CEF1B71A-2149-11E3-9DD3-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Return-Path: <jch@b-sasl-quonix.pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gitster@pobox.com
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

Ralf Baechle <ralf@linux-mips.org> writes:

>> diff --git a/arch/mips/boot/dts/include/dt-bindings b/arch/mips/boot/dts/include/dt-bindings
>> index 68ae388..08c00e4 120000
>> --- a/arch/mips/boot/dts/include/dt-bindings
>> +++ b/arch/mips/boot/dts/include/dt-bindings
>> @@ -1 +1 @@
>> -../../../../../include/dt-bindings
>> +../../../../../include/dt-bindings
>> \ No newline at end of file
>> -- 
>> 1.7.10.4
>
> I applied your patch - but now git-show shows it as an empty commit and
>
>   ls -lb arch/mips/boot/dts/include/dt-bindings
>
> still shows the \n at the end of the link target.
> ...
> So, I wonder if this is a git bug.

Sounds as if "git am" is losing the important bit of information
that new content ends with an incomplete line.

However, it does not reproduce for me.

    $ rm -fr /var/tmp/x && mkdir /var/tmp/x && cd /var/tmp/x
    $ git init
    $ ln -s 'a
    ' b
    $ git add b
    $ git commit -m initial
    $ ln -f -s a b
    $ git add b
    $ git commit -m fix
    $ git format-patch -1
    $ git checkout HEAD^
    $ git am 0001-*
    $ git diff HEAD^ HEAD
    diff --git a/b b/b
    index 7898192..2e65efe 120000
    --- a/b
    +++ b/b
    @@ -1 +1 @@
    -a
    +a
    \ No newline at end of file

I see the same with v1.7.10 (which may not match your version;
v1.7.10.4 is what was used by the patch submitter to prepare the
patch, and you did not say how you are applying the patches in your
message) and with more recent Git.  There is no such breakage.

I briefly suspected that you might be passing "--whitespace=fix" to
"am" and that may be incorrectly "fixing" the incomplete line, but
that is not the case.  I get the same result if I add the option to
"am" in the above transcript.

How are you applying the patch?  What is your Git version?
