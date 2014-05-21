Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 02:17:02 +0200 (CEST)
Received: from mail-wi0-f173.google.com ([209.85.212.173]:61071 "EHLO
        mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854846AbaEUARAcjY7Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 02:17:00 +0200
Received: by mail-wi0-f173.google.com with SMTP id bs8so6798988wib.12
        for <linux-mips@linux-mips.org>; Tue, 20 May 2014 17:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :organization:user-agent:in-reply-to:references:mime-version
         :content-type;
        bh=QlALLMhPsJa6NAK21MVzA9ggZGNUbd23KlnQgpF7XbI=;
        b=Ar/jeVDEvq2rK21hY0OdxrrMetYiGHpcPzMLdT+Vht+H8T9jwHKrNEUR3SCnQAfRWm
         u260Y/xzLbd5hYHpxrXYm51b42NE0CatIab38KFz2iRX3uG+3Kqi0vIWf/T8JmjXNAO/
         NXB0Y1lQfOSL+lw8w3WQ2qwYPPNG4ygjFikxfjg+CshOrSqwBae0iV+jxziwkholK/Sb
         vnm7qpKVsjt8zP7AY/DlAPoPvAiKvY6ToXc1dDyhGN2gwGXCZye3vWbntbC6eOyqZKL3
         QW9U+XMYY3ptUzdtu1K3rPe/wqMNRr0aodEBtjhOF7EyusLel85qwTI++mNxibLkWXsm
         VWqw==
X-Gm-Message-State: ALoCoQmc9N+KJ0oY3pC3xIX+I7Sl/abXjVLjdPe3iJdK1rzVTIU49ucQtgfRqrbgaZ2tDbcZiiIr
X-Received: by 10.194.177.131 with SMTP id cq3mr19926349wjc.23.1400631415010;
        Tue, 20 May 2014 17:16:55 -0700 (PDT)
Received: from radagast.localnet (jahogan.plus.com. [212.159.75.221])
        by mx.google.com with ESMTPSA id l9sm435823wic.21.2014.05.20.17.16.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 17:16:49 -0700 (PDT)
From:   James Hogan <james.hogan@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 09/15] MIPS: Add functions for hypervisor call
Date:   Wed, 21 May 2014 01:16:30 +0100
Message-ID: <3231132.Bvkfloh7jN@radagast>
Organization: Imagination Technologies
User-Agent: KMail/4.12.5 (Linux/3.15.0-rc5+; KDE/4.12.5; x86_64; ; )
In-Reply-To: <1400597236-11352-10-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1400597236-11352-10-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2093684.gDnYQ88kFA"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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


--nextPart2093684.gDnYQ88kFA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 20 May 2014 16:47:10 Andreas Herrmann wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>

These look similar to the kvm_hypercall${n} functions in 
arch/{x86,s390}/include/asm/kvm_para.h. Does it make sense to define that API 
in kvm_para.h for MIPS instead of this one?

Cheers
James
--nextPart2093684.gDnYQ88kFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTe/BtAAoJEGwLaZPeOHZ6WL8P/A5uNnTgtdpATJaTii5oQhhy
Q/U7c6kDzhbR8fuo2bdVezNABvgqsreXGAlRlSCLlbAlcLu6VRmdfk1ggppUw6rP
ZuPYmR5YuM+UQxf6vuqF7do0+NcSj4XZeuUNuB7KWftgjk1tqV5Y4ri1j3xKQJe8
KkE+Bzehn+ry8XvP8q8oBH5UcdDBExODNWycEjD5e8EF4WCfCkVjmSEqQcHgVv9f
RPLnyArDTSOquTZXc2XxCcj5ntUczE/WmTIVzDBMfGSNlzKzeFHiR9g8WYMPoZPY
FRkbcALENNbhyxT/cGl877o+ZavdQ6sntY5lIwxZmyA8RKwRoM9wwrXddoJ6mmhY
B7cOnv8MvEfcB3lTzyaDsq9mq8zhPeSuqT7cKr0Rqgd1NeYbeMLcumi7N48DHs4I
c3yQIRJXYZQsKK/+UU55h9+ZE/JWWxzpziaAoI5NhcNpV9vXENKNhbYmxjrCox/H
zjNB4Nz+6JAm9jAL/4MTtQOrlHyZ7l1iUtqhu26+i7RiVbq+qREa88wJi7/3yX2B
E+pumGJFReVryqsC6aON1obubzQj1Xj6OJjNIFdSkanEWNeBn9qsLOpEBxMc2g/J
xyV18gzp2PeKOj0T67ICJtS/CJStkdUYBwtcRIjYlp/5aW1hOcj/jaANOwc84/o8
Wh6mXRGS1MSJ898exT9E
=RvPV
-----END PGP SIGNATURE-----

--nextPart2093684.gDnYQ88kFA--
