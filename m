Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2014 10:45:50 +0200 (CEST)
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38945 "EHLO
        mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822134AbaE3IpsxcZxQ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 May 2014 10:45:48 +0200
Received: by mail-ob0-f174.google.com with SMTP id uz6so1492947obc.5
        for <multiple recipients>; Fri, 30 May 2014 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ehSRy4QiiOEmLcERlltVHxXXFTf2DYTnOJlYwvr0fKk=;
        b=lJ+BUHbG0g/tET89NrrsUh0p4PJAbHo0Y3pjwJaOAAFk375qOymA12q9CDWAKr7/5j
         Vykby6Lk65MLONZUBSbCNc1pH2MKGGfIGGJefeUdB2x747xUXnEZ0zaxut3ArWFytVJp
         XzofGVU7Vv0tD3mm0CX3SI9RrNEPEhJdfHIjDCtAb4uqaYW6mZWINNpsqbPnGprKkFbw
         C6LxNzJOWA+TcAighOyM66T0PvQ+LvMo4VZgb0TDrtjOQdlU8K9FpngBDIE2bobalZxU
         yRWhUjDYJWU09GxVuLQYKytmDgoiHYAb4/6qULzPuj+vBSdNBgrshIm53NTu7vzCNpAL
         1rBQ==
MIME-Version: 1.0
X-Received: by 10.182.199.5 with SMTP id jg5mr11889952obc.75.1401439541973;
 Fri, 30 May 2014 01:45:41 -0700 (PDT)
Received: by 10.76.124.167 with HTTP; Fri, 30 May 2014 01:45:41 -0700 (PDT)
In-Reply-To: <1397904586-9773-1-git-send-email-zajec5@gmail.com>
References: <1397904586-9773-1-git-send-email-zajec5@gmail.com>
Date:   Fri, 30 May 2014 10:45:41 +0200
Message-ID: <CACna6ryVwqeSW22R3QrE1DcRkRmrJFWbpuHHm55DiazqXfabqw@mail.gmail.com>
Subject: Re: [PATCH][next: 3.16] MIPS: BCM47XX: Slightly clean memory detection
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 19 April 2014 12:49, Rafał Miłecki <zajec5@gmail.com> wrote:
> Patch was tested on devices with 64 MiB and 256 MiB of RAM.
> It documents every part nicely and drops this hacky part of code:
> max = off | ((128 << 20) - 1);

I can't see this patch in any git tree. Am I missing some, or was this
patch forgotten?
