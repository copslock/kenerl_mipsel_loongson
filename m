Return-Path: <SRS0=DhUk=RA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FD7C43381
	for <linux-mips@archiver.kernel.org>; Mon, 25 Feb 2019 05:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81122084D
	for <linux-mips@archiver.kernel.org>; Mon, 25 Feb 2019 05:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="WZAYIfSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbfBYF2s (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 25 Feb 2019 00:28:48 -0500
Received: from forward103p.mail.yandex.net ([77.88.28.106]:44706 "EHLO
        forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbfBYF2s (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Mon, 25 Feb 2019 00:28:48 -0500
Received: from mxback19g.mail.yandex.net (mxback19g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:319])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id AC9ED18C10B1;
        Mon, 25 Feb 2019 08:28:42 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback19g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 9ULGu6UL3h-SfrWj73J;
        Mon, 25 Feb 2019 08:28:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1551072522;
        bh=2U0ewqH6074O3o/A1lkWgpM5pm96Y/E7gQaaIv6Z8aw=;
        h=Cc:To:From:Subject:Date:Message-Id;
        b=WZAYIfSN4hOWrfv2D80hMgIPNyKsN8HCL5XDT8JMJsYm6ZQYLHqS9eHs707Cm52O+
         TUK62LSZSzu1T+81ObvS7bd9LBvNNBSJy82Pn3DO3VkD1LjFOVGkNwEFhpqjHunJWc
         bUG3d2nVX59BPxFAqq61OHfr+QYRiPgmmfEA+QHY=
Authentication-Results: mxback19g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 7zis86YKDZ-SZReoeJx;
        Mon, 25 Feb 2019 08:28:39 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Message-Id: <20190225082840.SZReoeJx@smtp4o.mail.yandex.net>
Date:   Mon, 25 Feb 2019 13:28:29 +0800
Subject: Re: [RFC PATCH 0/2] MIPS: Loongson: ExtCC clocksource support
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     kernel@xen0n.name
Cc:     linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>,
        linux-mips@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wang Xuerui <wangxuerui@qiniu.com>,
        Huacai Chen <chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

CgoyMDE55bm0MuaciDI05pelIOS4i+WNiDU6Mzbkuo4ga2VybmVsQHhlbjBuLm5hbWXlhpnpgZPv
vJoKPgo+IEZyb206IFdhbmcgWHVlcnVpIDx3YW5neHVlcnVpQHFpbml1LmNvbT4gCj4KPiBIaSwg
Cj4KPiBUaGlzIGlzIG15IFdJUCBwYXRjaHNldCB0byBhZGQgc3VwcG9ydCBmb3IgdXNpbmcgdGhl
IG9uLWNoaXAgRXh0Q0MgCj4gKGV4dGVybmFsIGNvdW50ZXIpIHJlZ2lzdGVyIGFzIGNsb2Nrc291
cmNlLCB0byBib29zdCB0aGUgcmVhbC10aW1lIAo+IHBlcmZvcm1hbmNlIG9uIExvb25nc29uIHBs
YXRmb3JtLiBJJ20gcG9zdGluZyB0aGlzIHRvIHNvbGljaXQgY29tbWVudHMgCj4gYW5kIGdldCBz
b21lIG9mIHRoZSB1bnJlc29sdmVkIHF1ZXN0aW9ucyBhbnN3ZXJlZC4gCgpIaSBYdWVydWkKClRo
YW5rcyBhIGxvdCBmb3IgeW91ciB3b3JrcywgaG93ZXZlciwgdGhlIEV4dENDIGNhbiBiZSBpbmZs
dWVuY2VkIGJ5IHRoZSBmcmVxdWVuY3kgb2YgQ1BVIGNvcmUsIGFuZCB3ZSBoYXZlIGNwdWZyZXEg
d29ya2luZyBvbiBMb29uZ3Nvbi0zIHByb2Nlc3NvcnMsIHNvIHlvdSBzaG91bGQgbWFyayBpdCBj
b25mbGljdCB3aXRoIGNwdWZyZXEgZHJpdmVyLgoKQW5kIGFzIGZhciBhcyBJIGtub3csIEV4dEND
IGlzIGV2ZW4gbm90IHN5bmNocm9ub3VzIGJldHdlZW4gZGlmZmVyZW50IGNvcmVzLgoKSSdkIHBy
ZWZlciB0byB1c2UgZ3MzX0hQVCgweDNmZjAwNDA4KSAgcmVnaXN0ZXIgdG8gaW1wbGVtZW50IHRo
aXMgZmVhdGhlci4gQWxzbyBpdCBjYW4gYmUgYWNjZXNzZWQgZnJvbSBhbGwgdGhlIG5vZGVzLCBh
bmQgdGhlIGNsb2NrIGNvbWVzIGZyb20gIm5vZGUgY2xvY2siIHdoaWNoIHdpbGwgbm90IGVmZmVj
dGVkIGJ5IGNvcmUgZnJlcXVlbmN5Lgo+Cj4gKiBJIGRvbid0IGhhdmUgYWNjZXNzIHRvIG11bHRp
LXNvY2tldCBjY05VTUEgTG9vbmdzb24gYm9hcmRzLiBUaGUgY29kZSAKPiDCoCBtb3N0IGNlcnRh
aW5seSBkb2Vzbid0IHdvcmsgb24gc3VjaCBoYXJkd2FyZSwgc28gZWl0aGVyIHNvbWVvbmUgd2l0
aCAKPiDCoCBleHBlcnRpc2Ugd291bGQgdGVhY2ggbWUgaG93IHRvIGRvIHRoaXMsIG9yIGdldCB0
aGlzIGRvbmUgb24gdGhlaXIgCj4gwqAgb3duLiAKPiAqIEknbSBub3Qgc3VyZSBvZiB0aGUgcGlw
ZWxpbmUgYmVoYXZpb3Igb2YgdGhlIHJkaHdyIGluc3RydWN0aW9uIHVzZWQuIAo+IMKgIFRoZSBj
dXJyZW50IGltcGxlbWVudGF0aW9uIGhhcyBhIHN5bmMgKHJvdWdobHkgdGhlIHg4NiB3YXkpLCBh
bmQgSSdtIAo+IMKgIG5vdCBzdXJlIGlmIGl0IGNhbiBiZSBzYWZlbHkgb21pdHRlZCwgb3IgZXZl
biBtb3ZlZCBpbnRvIHRoZSBkZWxheSAKPiDCoCBzbG90IG9uIHJldHVybi4gCj4gKiBDbG9jayBz
a2V3IGNhbiBiZSBhIGNvbmNlcm4sIGJ1dCBpdCBzZWVtcyB0aGVyZSdzIG5vIGdlbmVyaWMgbWVj
aGFuaXNtIAo+IMKgIGZvciBjbG9ja3NvdXJjZSBjYWxpYnJhdGlvbi4gVGhlIHg4NiBjb2RlIGhh
cyBvbmUgc3VwcG9ydGluZyBQSVQvSFBFVC0gCj4gwqAgYmFzZWQgY2FsaWJyYXRpb24sIGJ1dCB0
aGF0IGNvZGUgbmV2ZXIgZ290IGV4dHJhY3RlZCB0byBjb21tb24gCj4gwqAgZnJhbWV3b3JrLiAK
PiAqIFRoZSBWRFNPIHBlcmZvcm1hbmNlIHNlZW1zIHZlcnkgYmFkIGNvbXBhcmluZyB0byB4ODYs
IGV2ZW4gYWZ0ZXIgCj4gwqAgYWRqdXN0aW5nIGZvciB0aGUgY3ljbGUgZnJlcXVlbmN5IGRpZmZl
cmVuY2UuIEJ1dCBJIGhhdmVuJ3QgdGhvcm91Z2hseSAKPiDCoCBwcm9maWxlZCB0aGlzIGFuZCBw
ZXJoYXBzIHdvbid0IGhhdmUgZW5vdWdoIHNwYXJlIHRpbWUgZm9yIGRvaW5nIHNvIAo+IMKgIChr
ZXJuZWwgd29yayBpc24ndCBwYXJ0IG9mIG15IGRheSBqb2IpLsKgIFNvIG1heWJlIHNvbWVvbmUg
Y291bGQgCj4gwqAgcHJvdmlkZSBzb21lIGhpbnRzIGluIHRoaXMgYXJlYT8gCj4KPiBDYW4gb25s
eSBjb21lIHVwIHdpdGggc28gbWFueSBwb2ludHMgZm9yIG5vdzsgSSdsbCBhZGQgaWYgbW9yZSBp
ZGVhcyAKPiB0dXJuIHVwLiAKPgo+IFAuUy4gSSBoYXZlIHRvIGNoYW5nZSB0byBteSBwZXJzb25h
bCBhZGRyZXNzIGZvciBvdXRnb2luZyBtYWlsczsgbXkgCj4gd29yayBhZGRyZXNzIGlzIGhvc3Rl
ZCBvbiBRUSBFbnRlcnByaXNlIE1haWwsIHdoaWNoIG1vc3QgY2VydGFpbmx5IGlzIAo+IGJsb2Nr
ZWQgYWx0b2dldGhlciBieSBsaW51eC1taXBzLm9yZy4gCj4KPiBXYW5nIFh1ZXJ1aSAoMik6IAo+
IMKgIE1JUFM6IExvb25nc29uOiBhZGQgZXh0Y2MgY2xvY2tzb3VyY2UgCj4gwqAgTUlQUzogVkRT
Tzogc3VwcG9ydCBleHRjYy1iYXNlZCB0aW1la2VlcGluZyAKPgo+IGFyY2gvbWlwcy9pbmNsdWRl
L2FzbS9jbG9ja3NvdXJjZS5owqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKyAKPiBhcmNoL21p
cHMvaW5jbHVkZS9hc20vbWFjaC1sb29uZ3NvbjY0L2V4dGNjLmggfCAyNiArKysrKysrKysgCj4g
YXJjaC9taXBzL2xvb25nc29uNjQvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCAxMyArKysrKyAKPiBhcmNoL21pcHMvbG9vbmdzb242NC9jb21tb24vTWFrZWZpbGXC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDUgKysgCj4gYXJjaC9taXBzL2xvb25nc29uNjQvY29tbW9u
L2V4dGNjLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDU0ICsrKysrKysrKysrKysrKysrKysgCj4g
YXJjaC9taXBzL2xvb25nc29uNjQvY29tbW9uL3RpbWUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDcgKysrIAo+IGFyY2gvbWlwcy92ZHNvL2dldHRpbWVvZmRheS5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDggKysrIAo+IDcgZmlsZXMgY2hhbmdlZCwgMTE0IGluc2Vy
dGlvbnMoKykgCj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvbWlwcy9pbmNsdWRlL2FzbS9tYWNo
LWxvb25nc29uNjQvZXh0Y2MuaCAKPiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9taXBzL2xvb25n
c29uNjQvY29tbW9uL2V4dGNjLmMgCj4KPiAtLSAKPiAyLjIwLjEgCj4K

