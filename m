Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 11:47:10 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:16392 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007718AbbIVJrIrFu6S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 11:47:08 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NV200EZMOIDTD70@mailout4.w1.samsung.com> for
 linux-mips@linux-mips.org; Tue, 22 Sep 2015 10:47:01 +0100 (BST)
X-AuditID: cbfec7f5-f794b6d000001495-bc-56012394151d
Received: from eusync3.samsung.com ( [203.254.199.213])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 3E.9D.05269.49321065; Tue,
 22 Sep 2015 10:47:00 +0100 (BST)
Received: from [106.120.53.23] by eusync3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NV2006OUOIB8ZB0@eusync3.samsung.com>; Tue,
 22 Sep 2015 10:47:00 +0100 (BST)
Message-id: <56012392.7020807@samsung.com>
Date:   Tue, 22 Sep 2015 11:46:58 +0200
From:   Jacek Anaszewski <j.anaszewski@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804
 Thunderbird/17.0.8
MIME-version: 1.0
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     David Howells <dhowells@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        devel@driverdev.osuosl.org, dev@openvswitch.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cachefs@redhat.com, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-omap@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, lustre-devel@lists.lustre.org,
        netdev@vger.kernel.org, rtc-linux@googlegroups.com
Subject: Re: [PATCH 00/38] Fixes related to incorrect usage of unsigned types
References: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
 <17571.1442842945@warthog.procyon.org.uk> <56011BB9.5030004@samsung.com>
In-reply-to: <56011BB9.5030004@samsung.com>
Content-type: text/plain; charset=windows-1252; format=flowed
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA03Sa0iTURjA8c7ey16Hg7el86BltgjL0Lx0OUlFfTDfsChKLEKyqS+6ciqb
        WkqQJmp5vxU2LUTnLC+znJaorJh5nXkhDQ3djMgEzTVLzTKNaYHffg/nz/N8ORQmMOP2lCQy
        hpVFiiNEJA/Xr3QOuxbuBAHupZXO6IO6j0DPi+oIpE58SaJ2fSuGWnt/cdHsnd84Gpo3kag4
        V8NBmsW7JKr/9J5AZmUPF5kzDQQyGpY4qCv7G4FG5xYI9K65hESNM2qAMp81Eij3fj4XGWpW
        CVSszMHRpC4LR73lWVxUslyIoTJVCoZmnoxxUU/bBI5q34xzUUepEL26dxccd2QUxrckY9C2
        4UxrXjfJ1M/lc5n2p7UcxpjRyWE0yttMctkIyUyOrgLGpB0mmeyGKsB8r3c8Z32ZdySUjZDE
        sbJ9x67ywjNbBsjoL/ybD5KriERg5KUDKwrS+6FuIo9YtxAOGOrIdMCjBHQFgKrptH/DJIBd
        lSu4peLTLrDfnLZmnN4Fxx+bOBaTtAdcmppesy19CS7rtcR6vxn+LDCs9Ta0MyzuHsMsSzE6
        kwvnZifXoi30GThUXUVaLKCzATSvOFhsRe+FBQNmzGKMPgpLTWp83duhpuYrlgtoxYYbig2Z
        YkNWCrAqYMvGhkTLg8Oknm5ysVQeGxnmFhIlrQfrH2G+CVR0eOsATQGRNZ/J3hQgIMRx8nip
        DkAKE9nw1TtAgIAfKo5PYGVRQbLYCFauAw4ULrLjP2w2+QvoMHEMe51lo1nZ/1cOZWWfCIIO
        953+Een1UZijkbEd/M/VdmlQtWxf7taVpBd7KBMGF190OR2Sn9SpMgZvSKaM7guePs2PZolu
        xvuKk5erMj3Qr/31SIr6YqqKJPsXL2ibfGrOxvsJgyRJ5cIDwVtP+aZuO8iYB4wtivO+/if+
        hAU2FO1eld4avLaHChf4akW4PFzs4YLJ5OK/DdfNQAQDAAA=
Return-Path: <j.anaszewski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: j.anaszewski@samsung.com
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

On 09/22/2015 11:13 AM, Andrzej Hajda wrote:
> On 09/21/2015 03:42 PM, David Howells wrote:
>> Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>>
>>> Semantic patch finds comparisons of types:
>>>      unsigned < 0
>>>      unsigned >= 0
>>> The former is always false, the latter is always true.
>>> Such comparisons are useless, so theoretically they could be
>>> safely removed, but their presence quite often indicates bugs.
>>
>> Or someone has left them in because they don't matter and there's the
>> possibility that the type being tested might be or become signed under some
>> circumstances.  If the comparison is useless, I'd expect the compiler to just
>> discard it - for such cases your patch is pointless.
>>
>> If I have, for example:
>>
>> 	unsigned x;
>>
>> 	if (x == 0 || x > 27)
>> 		give_a_range_error();
>>
>> I will write this as:
>>
>> 	unsigned x;
>>
>> 	if (x <= 0 || x > 27)
>> 		give_a_range_error();
>>
>> because it that gives a way to handle x being changed to signed at some point
>> in the future for no cost.  In which case, your changing the <= to an ==
>> "because the < part of the case is useless" is arguably wrong.
>
> This is why I have not checked for such cases - I have skipped checks of type
> 	unsigned <= 0
> exactly for the reasons above.
>
> However I have left two other checks as they seems to me more suspicious - they
> are always true or false. But as Dmitry and Andrew pointed out Linus have quite
> strong opinion against removing range checks in such cases as he finds it
> clearer. I think it applies to patches 29-36. I am not sure about patches 26-28,37.

Dropped 30/38 and 31/38 from LED tree then.

-- 
Best Regards,
Jacek Anaszewski
