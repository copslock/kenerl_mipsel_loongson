Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2018 00:28:02 +0100 (CET)
Received: from mail-ot1-x329.google.com ([IPv6:2607:f8b0:4864:20::329]:46457
        "EHLO mail-ot1-x329.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992850AbeKEX17gP5FN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2018 00:27:59 +0100
Received: by mail-ot1-x329.google.com with SMTP id q5so9718487otl.13;
        Mon, 05 Nov 2018 15:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QGdH9LZBPExg2UF37C/HDJO6TnG/srjlTbzycUrudHI=;
        b=KA1DuNS4zR+HqGaV7mzExkxLUYfFVi2xhsLii9TLWsZWBnvpvFmUktA9Rbt8HdIT9n
         QD4dlbUnqxmal2/REEeiP/4pH3LN070vu5kSnHzAKP55LxPTJjiWPNvFjrZE3wyp5t7L
         h74ta2fdvU2czNHKNLH8Zd1stmBY1ZeOAc/GcPE3C4P6k+hNfMDkpBUotLM0KpB6II//
         EXeS/4An5npl4WeqkUvNqKZIr0j9oWXyns5jOHx+8D9Zg+qXQ23Cd40zmd/em6APtZcS
         8n5bkSTaQz2tPjb2iasbcQQGJeqIV5JCgKTRPu6P40WicSJwmZNio0v1xrgv/MSiVccB
         mCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QGdH9LZBPExg2UF37C/HDJO6TnG/srjlTbzycUrudHI=;
        b=IccP1UCX145aJsb/zSwvfwfo3j15PNZGlnwI2n6SxOKHXZuhsZZyiJxtGjcLlNLIKb
         ArGAC3XURnCsKV/EfWYIZ3OjgRlaAOunThxOzDqb6g4ClDWRm48J0DLdA+77gKKUtMtI
         mWiosVQPHKgD16HJvPVhp33bhDkoarLc6E1LG0KM5UgPuRA3bg+aJtm3wj2QDZMv+gIV
         3psBekxZQi43JPkpioL4QPSglJDSYl1b/Wt0p7zD9IipyIk6LyK1VEB/J/FeMVhCyN4y
         QHq04OKPMdWbv3r7QC9RKSB08f/uVBlXmejJL6EObRC0eVa2RS832DjG0ivJZUirwjLJ
         ildw==
X-Gm-Message-State: AGRZ1gIWdIZimZlZZoKqCrgyVLyW4MgK2ebR80uuayQDrEDZ4u2mKmms
        XLH5FTWYcQtBfKMCuQ+1Gqohw1aZeo6Axyq5yfE=
X-Google-Smtp-Source: AJdET5cvM/b+TEAvLDS2aiu4ntt1oEcwnrz4FabYEgcu237ALAA9dWJBXupYEloYZeB5bb78QSZCi01i0x7VVVYMRwI=
X-Received: by 2002:a9d:734e:: with SMTP id l14mr13580301otk.270.1541460478750;
 Mon, 05 Nov 2018 15:27:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:2ea6:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 15:27:58 -0800 (PST)
In-Reply-To: <20181105230511.ierfp3yyqdwkggml@pburton-laptop>
References: <20181016103806.GA1544@makrotopia.org> <20181102020713.GA880@makrotopia.org>
 <20181105183615.nbvnfapug6zm42pg@pburton-laptop> <20181105201935.GF1389@makrotopia.org>
 <20181105230511.ierfp3yyqdwkggml@pburton-laptop>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Tue, 6 Nov 2018 00:27:58 +0100
Message-ID: <CAKR_QVJbaEq81Rgr8SOAzDzDTvm543Pbc3xMPit=ZD=sU5v0pQ@mail.gmail.com>
Subject: Re: [PATCH] mips: ralink: add accessors for MT7620 chipver and pkg
To:     Paul Burton <paul.burton@mips.com>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@freemail.hu>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <pozega.tomislav@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pozega.tomislav@gmail.com
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

Hi

ACK from me on this one. Tested and working.
