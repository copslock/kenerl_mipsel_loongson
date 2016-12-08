Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2016 01:30:45 +0100 (CET)
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33883 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991960AbcLHAaijjSzc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Dec 2016 01:30:38 +0100
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0386B209A2;
        Wed,  7 Dec 2016 19:30:37 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute7.internal (MEProxy); Wed, 07 Dec 2016 19:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        stressinduktion.org; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        mesmtp; bh=FQMIIY4d+ctK+VmyW0APhnuW/Ss=; b=OCaJsVgAGWHVHOdtfa2WR
        /R4B2CDhLYGcORn3Yq4WxZN/wwgJvC7Cmezen31d/b/0SW3zH1KA4RCt0jSvYSTE
        fOUWaktcj7808TdN0aQgxUPcnXzl8JRvxQlcG7UPci9m2vZI1cmEomy01odil04x
        aXcQOl1blIbbFFfwh23tZM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=FQMIIY4d+ctK+VmyW0APhnuW/Ss=; b=X6mPDFoiCXmHcDMxNs9P
        JH2jqtLg99Cqy9KccxwdXwD1iFWqS6DQDVWXshvhHMBTgTw/niWVH8HDqw5aRobQ
        f7H929QWAe+ObN8jpqsSGJmeHqnYY7n2CkmYDSDHzjgBQPBG2l6Mi9S116vv7QI1
        L87HWrbUzR96S5YvE2m871I=
X-ME-Sender: <xms:rKlIWKO5nzRQ_d-Jlu2dqndL9eMEQa2hj6tcoXa1dx4J7rZmOAgbgQ>
X-Sasl-enc: EBQ1uLfe/+HBwD78gekAQLWr8x3n1mVlMmgP/nckBxyS 1481157036
Received: from z.localhost (unknown [213.55.184.182])
        by mail.messagingengine.com (Postfix) with ESMTPA id C08277E7A5;
        Wed,  7 Dec 2016 19:30:35 -0500 (EST)
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Netdev <netdev@vger.kernel.org>, linux-mips@linux-mips.org
References: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>
From:   Hannes Frederic Sowa <hannes@stressinduktion.org>
Message-ID: <095cac5b-b757-6f4a-e699-8eedf9ed7221@stressinduktion.org>
Date:   Thu, 8 Dec 2016 01:30:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <hannes@stressinduktion.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hannes@stressinduktion.org
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

Hi Jason,

On 07.12.2016 19:35, Jason A. Donenfeld wrote:
> I receive encrypted packets with a 13 byte header. I decrypt the
> ciphertext in place, and then discard the header. I then pass the
> plaintext to the rest of the networking stack. The plaintext is an IP
> packet. Due to the 13 byte header that was discarded, the plaintext
> possibly begins at an unaligned location (depending on whether
> dev->needed_headroom was respected).
> 
> Does this matter? Is this bad? Will there be a necessary performance hit?

Your custom protocol should be designed in a way you get an aligned ip
header. Most protocols of the IETF follow this mantra and it is always
possible to e.g. pad options so you end up on aligned boundaries for the
next header.

GRE-TEB for example needs skb_copy_bits to extract the header so it can
access them in an aligned way.

> In order to find out, I instrumented the MIPS unaligned access
> exception handler to see where I was actually in trouble.
> Surprisingly, the only part of the stack that seemed to be upset was
> on calls to ip_hdr(skb)->version.
> 
> Two things disturb me about this. First, this seems too good to be
> true. Does it seem reasonable to you that this is actually the only
> place that would be problematic? Or was my testing methodology wrong
> to arrive at such an optimistic conclusion?
> 
> Secondly, why should a call to ip_hdr(skb)->version cause an unaligned
> access anyway? This struct member is simply the second half of a
> single byte in a bit field. I'd expect for the compiler to generate a
> single byte load, followed by a bitshift or a mask. Instead, the
> compiler appears to generate a double byte load, hence the exception.
> What's up with this? Stupid compiler that should be fixed? Some odd
> optimization? What to do?

I don't see an issue with that at all. Why do you think it could be a
problem?

Bye,
Hannes
