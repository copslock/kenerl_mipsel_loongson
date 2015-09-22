Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 11:14:01 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:14135 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007582AbbIVJN7Wa2H2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 11:13:59 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NV200D60MZ4DV70@mailout4.w1.samsung.com> for
 linux-mips@linux-mips.org; Tue, 22 Sep 2015 10:13:52 +0100 (BST)
X-AuditID: cbfec7f4-f79c56d0000012ee-f0-56011bcf086c
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 04.26.04846.FCB11065; Tue,
 22 Sep 2015 10:13:51 +0100 (BST)
Received: from [106.116.147.88] by eusync1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NV2009W4MZ1JI10@eusync1.samsung.com>; Tue,
 22 Sep 2015 10:13:51 +0100 (BST)
Subject: Re: [PATCH 00/38] Fixes related to incorrect usage of unsigned types
To:     David Howells <dhowells@redhat.com>
References: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
 <17571.1442842945@warthog.procyon.org.uk>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        devel@driverdev.osuosl.org, dev@openvswitch.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cachefs@redhat.com, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mm@kvack.org,
        linux-omap@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        lustre-devel@lists.lustre.org, netdev@vger.kernel.org,
        rtc-linux@googlegroups.com
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-id: <56011BB9.5030004@samsung.com>
Date:   Tue, 22 Sep 2015 11:13:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-version: 1.0
In-reply-to: <17571.1442842945@warthog.procyon.org.uk>
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHfXeumovjdPbirViJJGkKoi8VYVdOH4KgskjCTnpQy6ltahlU
        Vlg6r5lGOEPxRs37phUqRtNtNa95I7vMTLAyzWZ562ZNi/z2e/7P7w/Ph4fGRJO4Ex0ZHcfL
        orkoCWmDt/8y9Hl1O4Mgn9k5D/SiuotAdbdrCFSd9IBEuvZmDDV3fKPQpyvfcdQ/M0UiZbZG
        gDRzKSRSjw4SyFxqpJA53USgYdOCAD3J/EygoelZAvU1FpCoYaIaoPTaBgJl5+VQyFS5SCBl
        aRaOxrQZOOooyaBQwY9cDBWXJ2No4u4rChlb3+Coqu01hfRFjuhRagoIdGPzhztJ1tTSirPN
        N56SrHo6h2J196oE7HCaQcBqSi+xV4ufk+zY0CJgp1oGSDazXgXYL2q3A7bHbLaF8VGRCbxs
        8/YTNhE5A90gtn31uZayDUmgepUC0DRk/OBgRaICWP9BR9hjqiEVwIYWMWUAlvSOUMvDOwC7
        9Jcxi2XP7If9FSrSwg6MB3xbXreUi5gYqGxLwywFjKmk4Ezu7JJEMhvhT83QEgsZT3jdPLHE
        OOMOxz/WUxYWM0ehsXPyr2MH52+acAtbM/7QoG0iLZdijDccfuZpiTFmLdRUTmLZgMlf0cj/
        b+WvsIoApgJiPj40Vn4yXOrrLeek8vjocO/QGKkaLD/B14egRL9FCxgaSGyF+zKtgkQElyBP
        lGoBpDGJg9CXAkEiYRiXeJ6XxYTI4qN4uRY407hkjfBO49QhERPOxfGneT6Wl/3bCmhrpySg
        iM3y2mtVqAyDqtCq8SPm2scGTnsqUXL//UKPOaxOdzDLL6/wmoMsckfgxbE2Xceo6pbvgsvh
        TsdUl/Xr9AIfUu21yeesvSJbsKekQFn8cuuIWOrgv+v4B9fdTYEXHI3JO1vng8RnAnT985w5
        OCRgxG4oHhmj3ane4BZXceeEBJdHcL6emEzO/Qb5Mt9qAAMAAA==
Return-Path: <a.hajda@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.hajda@samsung.com
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

On 09/21/2015 03:42 PM, David Howells wrote:
> Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> 
>> Semantic patch finds comparisons of types:
>>     unsigned < 0
>>     unsigned >= 0
>> The former is always false, the latter is always true.
>> Such comparisons are useless, so theoretically they could be
>> safely removed, but their presence quite often indicates bugs.
> 
> Or someone has left them in because they don't matter and there's the
> possibility that the type being tested might be or become signed under some
> circumstances.  If the comparison is useless, I'd expect the compiler to just
> discard it - for such cases your patch is pointless.
> 
> If I have, for example:
> 
> 	unsigned x;
> 
> 	if (x == 0 || x > 27)
> 		give_a_range_error();
> 
> I will write this as:
> 
> 	unsigned x;
> 
> 	if (x <= 0 || x > 27)
> 		give_a_range_error();
> 
> because it that gives a way to handle x being changed to signed at some point
> in the future for no cost.  In which case, your changing the <= to an ==
> "because the < part of the case is useless" is arguably wrong.

This is why I have not checked for such cases - I have skipped checks of type
	unsigned <= 0
exactly for the reasons above.

However I have left two other checks as they seems to me more suspicious - they
are always true or false. But as Dmitry and Andrew pointed out Linus have quite
strong opinion against removing range checks in such cases as he finds it
clearer. I think it applies to patches 29-36. I am not sure about patches 26-28,37.

Regards
Andrzej

> 
> David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
