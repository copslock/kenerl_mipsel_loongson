Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 13:25:23 +0200 (CEST)
Received: from mx1.moondrake.net ([212.85.150.166]:54989 "EHLO
        mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1492479Ab0EDLZU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 13:25:20 +0200
Received: by mx1.mandriva.com (Postfix, from userid 501)
        id 54489274016; Tue,  4 May 2010 13:25:19 +0200 (CEST)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.mandriva.com (Postfix) with ESMTP id A5E40274015;
        Tue,  4 May 2010 13:25:17 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
        by office-abk.mandriva.com (Postfix) with ESMTP id 7F141835BA;
        Tue,  4 May 2010 13:43:13 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
        by anduin.mandriva.com (Postfix) with ESMTP id 0E2AEFF855;
        Tue,  4 May 2010 13:25:49 +0200 (CEST)
From:   Arnaud Patard <apatard@mandriva.com>
To:     yajin <yajinzhou@vm-kernel.org>
Cc:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        wuzhangjin@gmail.com
Subject: Re: [PATCH 0/12] add basic gdium support
References: <z2l180e2c241005040254y895e5456sf37194c97f3f739f@mail.gmail.com>
Organization: Mandriva
Date:   Tue, 04 May 2010 13:25:48 +0200
In-Reply-To: <z2l180e2c241005040254y895e5456sf37194c97f3f739f@mail.gmail.com> (yajin's message of "Tue, 4 May 2010 17:54:51 +0800")
Message-ID: <m34oinx60z.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

yajin <yajinzhou@vm-kernel.org> writes:

Hi,

> Gdium is a netbook based on loongson2f CPU and sm502 SOC. It does NOT
> have a south bridge. The sm502 SOC is used for LCD controller and
> audio output. This series of patches are adding gdium support to
> ralf's linux-mips repository.

what's wrong with you ? I told you I was going to send patches and now
you're sending yours (judging by a quick look) which:
- are incomplete and/or broken
- no respect of patch authorship

The gpio patch is even a dup of a patch I sent last week...

What's the aim here ? Sending your patches before mines to annoy me ?


Arnaud
