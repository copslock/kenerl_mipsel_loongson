Return-Path: <SRS0=zZS8=QE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6B7C282C8
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 13:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B44F20989
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 13:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJ8opvlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfA1N7d (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:59:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38733 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfA1N7d (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 28 Jan 2019 08:59:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so14297710lja.5
        for <linux-mips@vger.kernel.org>; Mon, 28 Jan 2019 05:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=99uQEixhQClcS2n/0GedsIly21bt501S/6G+8PRROzY=;
        b=OJ8opvlkvym1DthqLuURYSEI7P31feT2ioxShHXGqa55VoMB9MdJerLsYrGBanG/Ay
         clRIPCaLgTBNurAKlPRmsKzRyqD+ZGBnLnqNh7lDH1PJadu9J2HQXogVlEY0VRv7nStC
         YyQeoPGPjB5YzjM6K9EXguUHAOd4a8SMH49GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=99uQEixhQClcS2n/0GedsIly21bt501S/6G+8PRROzY=;
        b=I4Etli4aHAL1uwsYwQMRjZqFUB8KbwlJUJmLuGb/s76Xp1lMoKT2263fUbcIF4BEew
         p4PElfzDKVlRni8Rr/H+Wx2ap3onFqRMOt2YUPeHkptHf/MfuefaszjwCCCAbq793qt8
         T7sue9C9YL2UZASae1vvubmIEQrMMrgcpiWIujDGnu2gbChG0C/HL5CPgCvwUIwZhgyO
         6hZzeyEVH/OaBVOKxU8b5XAcaOh36TRQRqFtBCqeeC6twymdWvW0nVM1EAin39t7zPbY
         jOMrLfNM2x6Opv1FzpdkH//LccKMyCCDPYfvU0SCuI1+A+KzcUxbYcEZwnZu2yWUx1L6
         6JUQ==
X-Gm-Message-State: AJcUukem6FvnVEqfQ9azjcPMQi3RHL5472gAUHPoPShyLdZQwRjuI05+
        rQe5xWViM8C88LzcIw7qq4ukwloKW1c8KO3X+G+bYw==
X-Google-Smtp-Source: ALg8bN7AVzCFnSmZ00nJgfwWbrHKV/K7ZbrrwlGCthF0+sI1AjuPWtEcQ1TiTF5Z94pWaMfvRYO+xfhQofPgUVClGh4=
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr16720694ljb.126.1548683970839;
 Mon, 28 Jan 2019 05:59:30 -0800 (PST)
MIME-Version: 1.0
References: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com> <1548410393-6981-2-git-send-email-zhouyanjie@zoho.com>
In-Reply-To: <1548410393-6981-2-git-send-email-zhouyanjie@zoho.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Jan 2019 14:59:19 +0100
Message-ID: <CACRpkdYe2NsBFC-KBQXhmsSJ-S7wN9cZZuEPKHSfQe4HZUXTPg@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/4] Pinctrl: Ingenic: Fix bugs caused by
 differences between JZ4770 and JZ4780.
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>, syq@debian.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, 772753199@qq.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This series looks good to me, but it would be nice if you could
fix the warning pointed out by Paul, and I would also
like some ACK from Paul C on the patches so I know this is
fine with him.

Yours,
Linus Walleij
