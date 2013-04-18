Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Apr 2013 09:57:58 +0200 (CEST)
Received: from mail-lb0-f179.google.com ([209.85.217.179]:40507 "EHLO
        mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823908Ab3DRH54jI9tB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Apr 2013 09:57:56 +0200
Received: by mail-lb0-f179.google.com with SMTP id t1so2428784lbd.38
        for <linux-mips@linux-mips.org>; Thu, 18 Apr 2013 00:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=ePIFjrKKmIlIUXbavIf25T7o/3ZvT2Uufb+Cr3gpES8=;
        b=m47ZSW3EOJRf8kICvhWS7nuhlqPfybJHRhe2fMybHzo8XRBkO75Wa6y6YuvFLUw0fm
         vtcW24xOoqUNY1ArV61+iKdyKNtRF+Nj0qO0/EF45kiZLz0G9Nx65syL6ynPjV+O8n7V
         k54sIjfrpPP3yuxz6uMvrf9W1FexBqHiV5pnDV8sBld+OQPSZYoQj4C6a6qWGk/kLHhT
         lXJKeh1GbpU9FiKizKzTtwDN8kKtKllfpIgk8zCAirtVgE2aYR/oiK72VKycrOepHG3z
         40eBwXru1WLBx+5nkggoit1iLWw9OhkccIVL3F6EADu9Qjigba/rp9FG3TGNnLL8R2ha
         I0zQ==
MIME-Version: 1.0
X-Received: by 10.112.159.65 with SMTP id xa1mr5334429lbb.35.1366271870880;
 Thu, 18 Apr 2013 00:57:50 -0700 (PDT)
Received: by 10.152.8.227 with HTTP; Thu, 18 Apr 2013 00:57:50 -0700 (PDT)
In-Reply-To: <CAF1ivSZXGY0dUSTVan-VuMVaQrtUOEZuRqhqmnNe-euCj03XAA@mail.gmail.com>
References: <CAF1ivSZXGY0dUSTVan-VuMVaQrtUOEZuRqhqmnNe-euCj03XAA@mail.gmail.com>
Date:   Thu, 18 Apr 2013 15:57:50 +0800
Message-ID: <CAF1ivSYfBU9EqMoV0Y6+aJ--PoWAoZMGjpMUCDA4q4aEtCt1BQ@mail.gmail.com>
Subject: Re: hard lockup problem
From:   Lin Ming <minggr@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <minggr@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minggr@gmail.com
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

On Thu, Apr 18, 2013 at 3:13 PM, Lin Ming <minggr@gmail.com> wrote:
> Hi list,
>
> I encounter a problem that cpu stuck with irq disabled, which is known
> as hard lockup.
> I know there is NMI hard lockup detector for x86, which can dump the
> back trace of the hard lockup.
>
> Is there any similar feature for MIPS?

And it's MIPS32 4K cpu running 2.6.30 kernel.

>
> Thanks,
> Lin Ming
