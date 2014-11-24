Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 20:14:49 +0100 (CET)
Received: from mail-qg0-f42.google.com ([209.85.192.42]:45030 "EHLO
        mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006914AbaKXTOsZUtuP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 20:14:48 +0100
Received: by mail-qg0-f42.google.com with SMTP id z107so5764197qgd.15
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 11:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=PfL3S7FCBWb0X9ZWPoDDmwbTNIbr4RzPrdJi/E/42nM=;
        b=OJM7cxcVfSs8AN6AlaOgl2z0K2dBmDFTOLW9GL1GAo0npyZrY165/ZP0qbdj7LM3iE
         +0YDbISCaSXSW266bK+SUdGGGAcifjF8qvvzQZ+bGLKTRkJA1jGiteMjjZqoozLRD4V4
         zrkJfgcoyBloGbyRZ9uE/7Q1XYXwgu45F9LVhki7mtzg5Ao+Z0O3C93/d38v+vK08XZU
         ctw0xK9IbBrl7aQqVR7gHF8w6wchESwxcyZUFDnnJuU3MKCI/FTdRCFV4jMCHGndXTHG
         rbmgLTerEIRAkZ6xwGNiTue6l1BrlRROdRfDo0BSSYpykBwgs6cFoeDuEGgdshhZBaRZ
         m+Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=PfL3S7FCBWb0X9ZWPoDDmwbTNIbr4RzPrdJi/E/42nM=;
        b=HFa1MqvDhQSQICLYzz6YiZmAzjSlIDUsDhssZXzh5guSeG8IhGDltbCsBtkwTx9uYv
         o9wMo5eD+kH+i9yxZDaimy3Fh05pIt1QvPm3bweVqtwWgvlfkBi7M5TgpQhTw4ZR+Jm4
         nGzLSxK+mfQW+byvZ3VQrJtkRAEHFwRinhLXs=
MIME-Version: 1.0
X-Received: by 10.224.121.1 with SMTP id f1mr11183543qar.76.1416856482700;
 Mon, 24 Nov 2014 11:14:42 -0800 (PST)
Received: by 10.140.39.170 with HTTP; Mon, 24 Nov 2014 11:14:42 -0800 (PST)
In-Reply-To: <547381D7.2070404@de.ibm.com>
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
        <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com>
        <15567.1416835858@warthog.procyon.org.uk>
        <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com>
        <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com>
        <547381D7.2070404@de.ibm.com>
Date:   Mon, 24 Nov 2014 11:14:42 -0800
X-Google-Sender-Auth: DN8e4-wiEsv9kGAdwGbeuGi5g-g
Message-ID: <CA+55aFy+dunTcdgB4-BXsYiLDk9pf8b_L74ky-dMixpbX3JQQA@mail.gmail.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-x86_64@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
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

On Mon, Nov 24, 2014 at 11:07 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> Looks really nice, but does not work with ACCESS_ONCE is on the left-hand side:

Oh, I forgot about that. And that was indeed why I had done that whole
helper macro originally, with ACCESS_ONCE() itself just being the
dereference of the pointer.

Duh.

                  Linus
