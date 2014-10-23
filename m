Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 16:26:59 +0200 (CEST)
Received: from mail-ig0-f181.google.com ([209.85.213.181]:40587 "EHLO
        mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012257AbaJWO06aXC1z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 16:26:58 +0200
Received: by mail-ig0-f181.google.com with SMTP id l13so1566355iga.14
        for <multiple recipients>; Thu, 23 Oct 2014 07:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ua2d3a14TLB64YoFe32xmHzQtZthz5Mezv7yHlbb3Mg=;
        b=UyoHz3YPYdqiHkdqn6x0r3g3L+KoH/9n9+/Z9/MEKhzXFRSorBhG8yvZwGI+Tb7XXW
         z5l82KoHG9LzELH3MJW+9lVx3gjPXNbs7kWQbf21XhRoiK6mc5ysOC1rV1ycAwsIDSxd
         XwWwgws5Ffj4bmP3DgPdSWQQLXxrVs/+Qw/UFaGkGhmZlK6mghIxSyXawkOZ1Z6OAP4D
         yZwBvZNFNsNd17OF/b5URg2Cma+s7VkhoZyQc1UdKPtJcpqoG/FmX3/Ie2caz9/uqr6Z
         4LID++bQTHqjBHHPyiAlsPdoqWSJ+M5mBtHYuwv+TSZWiRTbJ4XUy2iax14uQaldousu
         wFRQ==
X-Received: by 10.42.79.205 with SMTP id s13mr2181035ick.71.1414074412030;
 Thu, 23 Oct 2014 07:26:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.169.25 with HTTP; Thu, 23 Oct 2014 07:26:31 -0700 (PDT)
In-Reply-To: <CAGXxSxXTroiohkMVDfCxFeDo4ty+q5WKFR5Q8p3oc8eut8BfsQ@mail.gmail.com>
References: <1400997742-9393-1-git-send-email-chenj@lemote.com> <CAGXxSxXTroiohkMVDfCxFeDo4ty+q5WKFR5Q8p3oc8eut8BfsQ@mail.gmail.com>
From:   cee1 <fykcee1@gmail.com>
Date:   Thu, 23 Oct 2014 22:26:31 +0800
Message-ID: <CAGXxSxXF7GRWTvWLdbpLN9P05V9xq=00Joh1a-Qwn6vuFfzrJg@mail.gmail.com>
Subject: Re: [v4, Resend] MIPS: lib: csum_partial: more instruction paral
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        =?UTF-8?B?5ZC056ug6YeR?= <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <fykcee1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fykcee1@gmail.com
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

Hi Ralf,

Are you happy with the patch and the math explanation? Then it may be
merged? :-)



---
Regards,

- cee1
