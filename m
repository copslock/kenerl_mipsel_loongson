Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 07:57:38 +0100 (CET)
Received: from mail-yk0-f194.google.com ([209.85.160.194]:34728 "EHLO
        mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009232AbcARG5gzf-8P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 07:57:36 +0100
Received: by mail-yk0-f194.google.com with SMTP id v14so37391990ykd.1;
        Sun, 17 Jan 2016 22:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to
         :message-id;
        bh=Ets8Bh9Pt6DA0xIc5BSdfutLQrQEhUGK3MzIvo8M2Yw=;
        b=pgq5QyOq0N24djDCiVb9qH1LWyTI3VPsMbWYL2BZyChU0qsOhRP+lQjMSoNfUs/3LP
         ziyEL7xh3BDdb3oJOJWSMfjJyp6AxVB5YrVf7R13tfJyFP9XgiEDPyVqNkUR1PEjd2gJ
         3kB8K1wJvH6jyrOc9AyRaifUD9wvijz6Aez9egJxjhgah/SVG7fBW7s2B2bihiau+qOT
         dUl+PX3VS2r2OV6FenGONzQN4T2Ev7R2h1ofM7OL8FppTKGKnHiipyB32zeWVJtAtPTq
         r8LjhQW78xBoRLViiDE8Zk0mXcRrv4PaYjsoWFRYk/OUnCeuGKjUbqpX1R/lrkswkCRL
         kuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to
         :message-id;
        bh=Ets8Bh9Pt6DA0xIc5BSdfutLQrQEhUGK3MzIvo8M2Yw=;
        b=aRH/7BgpyRqG7fwqRpdtApvjIg3dzvkf0aqvb70BKTqbUnEVRViHiU3Ee6hoqBLGoi
         HcVXzV/CjxC3W7lCDulpb47HZr7y+z0WC1oRAOJ5/n63Y5OKXKO6SfE8e9Dnyo9DGYYn
         YCVEQGBbNDNTDL3FuB4oymnj8G3PZ+zkRQvU9Udp2jilMrx8Ll8okGC+NRQJpaPu7cha
         tIO+3eeUdyu0QpimSC3KDo96TeInwr6BzrZF/cUjC3PdrDZkZjxfkHGnDcVCmIiOzF8o
         92Rg4z+vupfE5cRu0DlqsWNcQfMLJLLT70ZfQPiDGt7yGeBX5TfLXNcCIBihL6IIDQri
         beOQ==
X-Gm-Message-State: ALoCoQmWZ2bcYgezORnXsUlwLm3k8Pm/qU8nnudtGKs7uzccofduaoqKP9D90YA6qUIwlAlTMFlT1FwhMuNN8MWKBh/5UTFpLg==
X-Received: by 10.129.33.65 with SMTP id h62mr14174733ywh.139.1453100251083;
        Sun, 17 Jan 2016 22:57:31 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:903:9f9b:ce2a:20c0? ([2001:470:d:73f:903:9f9b:ce2a:20c0])
        by smtp.gmail.com with ESMTPSA id t11sm17618219ywg.16.2016.01.17.22.57.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Jan 2016 22:57:30 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <1453024955-13570-1-git-send-email-noltari@gmail.com>
References: <1453024955-13570-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 1/2] bmips: improve BCM6328 device tree
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Sun, 17 Jan 2016 22:57:23 -0800
To:     =?ISO-8859-1?Q?=C1lvaro_Fern=E1ndez_Rojas?= <noltari@gmail.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jogo@openwrt.org, cernekee@gmail.com
Message-ID: <420C870C-0A83-4115-8EDD-B8F46C17339D@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On January 17, 2016 2:02:34 AM PST, "Álvaro Fernández Rojas" <noltari@gmail.com> wrote:
>Adds bcm6328-leds node to bcm6328.dtsi
>
>Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

-- 
Florian
