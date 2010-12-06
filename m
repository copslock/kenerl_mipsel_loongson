Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Dec 2010 19:03:04 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:36863 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492067Ab0LFSCq convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Dec 2010 19:02:46 +0100
Received: by eyd9 with SMTP id 9so6345914eyd.36
        for <multiple recipients>; Mon, 06 Dec 2010 10:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=MuzeGz/Z/sEPplzDUDAq/Cl9br7ToDSEt8rGFouJ++E=;
        b=J38QA814CF1lP1XRYKd9P+tj0T8CJWgy8p7y88QdhUcfgT/MV/2vzqfYGI/hgUPS/G
         +MYksTGj5MSpIPctCerfbp9ND8YBsDLZmuMulB0kNBtqH3rEqk+F3zQSkLKDFCHo1Ryh
         HHpSCorTqtPgCrfeGVGP+Uz77yM95Tjgk5JcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vv9qMyXplom8SFjAO3xL4vSwmMJIJqi2v3GkKhnq9z1QeP4vT/K2gQ2X+ReuiNdioa
         Vi5n8fC7Za2p2kKVfjeV+kiTdf/DLEbLEPRBN0MCd2BmImNdyuEORryA2qWC6WXMe1Yw
         dHxu9brskRQLPgnQtDW14pJNGIXAmNgp2DCvE=
Received: by 10.213.23.10 with SMTP id p10mr852913ebb.0.1291658565465; Mon, 06
 Dec 2010 10:02:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.204.46.199 with HTTP; Mon, 6 Dec 2010 10:02:25 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1012061739200.17185@eddie.linux-mips.org>
References: <1291617494-18430-1-git-send-email-mattst88@gmail.com>
 <20101206173040.GA18372@ericsson.com> <alpine.LFD.2.00.1012061739200.17185@eddie.linux-mips.org>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 6 Dec 2010 18:02:25 +0000
Message-ID: <AANLkTikWRsgHao_eb4W47b=E4vm6z=hi36JE_VBtD6Rg@mail.gmail.com>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of interrupts
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Guenter Roeck <guenter.roeck@ericsson.com>,
        Jean Delvare <khali@linux-fr.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Dec 6, 2010 at 5:56 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
>  Matt, thanks for keeping your eye on these bits and reviving them; I've
> meant to do so for a long time now, but never came to it.  Please note
> however, as I'm the original author, my original Signed-off-by markups
> continue to apply and you should be quoting them with the submissions.
> You should only add your own Signed-off-by annotation if you made any
> changes and it would make sense to state what these changes were.

Sure thing. Will fix. For patches 2 and 3 of the other series, I don't
think I was ever 100% sure that you were the author, since they were
living on OpenWRT.org and I couldn't find them in any mailing list
archives. Can you confirm that these 4 patches are all yours?

Matt
