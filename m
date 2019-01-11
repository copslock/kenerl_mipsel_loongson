Return-Path: <SRS0=rYMR=PT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27686C43387
	for <linux-mips@archiver.kernel.org>; Fri, 11 Jan 2019 12:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025A820874
	for <linux-mips@archiver.kernel.org>; Fri, 11 Jan 2019 12:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbfAKMss (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:48:48 -0500
Received: from mail.loongson.cn ([114.242.206.163]:46289 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbfAKMsr (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 11 Jan 2019 07:48:47 -0500
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2019 07:48:46 EST
Received: by ajax-webmail-mail (Coremail) ; Fri, 11 Jan 2019 20:40:49 +0800
 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
X-Originating-IP: [10.20.4.210]
Date:   Fri, 11 Jan 2019 20:40:49 +0800 (GMT+08:00)
From:   =?UTF-8?B?5b6Q5oiQ5Y2O?= <xuchenghua@loongson.cn>
To:     paul.burton@mips.com
Cc:     ysu@wavecomp.com, pburton@wavecomp.com, linux-mips@vger.kernel.org,
        chenhc@lemote.com, zhangfx@lemote.com, wuzhangjin@gmail.com,
        linux-mips@linux-mips.org,
        =?UTF-8?B?6buE5rKb?= <huangpei@loongson.cn>
Subject: Re: [PATCH 1/2] MIPS: Loongson, add sync before target of branch
 between llsc
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.6a_preview build
 20150605(69773.7394) Copyright (c) 2002-2019 www.mailtech.cn loongson
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: KzWneWZvb3Rlcl90eHQ9OTYwOjczNA==
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <37e1dca1.5987.1683cede2ff.Coremail.xuchenghua@loongson.cn>
X-CM-TRANSID: QMiowPDx77_RjjhcIQhtAA--.2513W
X-CM-SenderInfo: x0xfxv5qjk3to6or00hjvr0hdfq/1tbiAQAHC1EBqdJH0QAAsw
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

SGkgUGF1bCBCdXJ0b24sDQoNCkZvciBMb29uZ3NvbiAzQTEwMDAgYW5kIDNBMzAwMCwgd2hlbiBh
IG1lbW9yeSBhY2Nlc3MgaW5zdHJ1Y3Rpb24gKGxvYWQsIHN0b3JlLCBvciBwcmVmZXRjaCkncyBl
eGVjdXRpbmcgb2NjdXJzIGJldHdlZW4gdGhlIGV4ZWN1dGlvbiBvZiBMTCBhbmQgU0MsIHRoZSBz
dWNjZXNzIG9yIGZhaWx1cmUgb2YgU0MgaXMgbm90IHByZWRpY3RhYmxlLiAgQWx0aG91Z2ggcHJv
Z3JhbW1lciB3b3VsZCBub3QgaW5zZXJ0IG1lbW9yeSBhY2Nlc3MgaW5zdHJ1Y3Rpb25zIGJldHdl
ZW4gTEwgYW5kIFNDLCB0aGUgbWVtb3J5IGluc3RydWN0aW9ucyBiZWZvcmUgTEwgaW4gcHJvZ3Jh
bS1vcmRlciwgbWF5IGR5bmFtaWNhbGx5IGV4ZWN1dGVkIGJldHdlZW4gdGhlIGV4ZWN1dGlvbiBv
ZiBMTC9TQywgc28gYSBtZW1vcnkgZmVuY2UoU1lOQykgaXMgbmVlZGVkIGJlZm9yZSBMTC9MTEQg
dG8gYXZvaWQgdGhpcyBzaXR1YXRpb24uDQoNClNpbmNlIDNBMzAwMCwgd2UgaW1wcm92ZWQgb3Vy
IGhhcmR3YXJlIGRlc2lnbiB0byBoYW5kbGUgdGhpcyBjYXNlLiAgQnV0IHdlIGxhdGVyIGRlZHVj
ZSBhIHJhcmVseSBjaXJjdW1zdGFuY2UgdGhhdCBzb21lIHNwZWN1bGF0aXZlbHkgZXhlY3V0ZWQg
bWVtb3J5IGluc3RydWN0aW9ucyBkdWUgdG8gYnJhbmNoIG1pc3ByZWRpY3Rpb24gYmV0d2VlbiBM
TC9TQyBzdGlsbCBmYWxsIGludG8gdGhlIGFib3ZlIGNhc2UsIHNvIGEgbWVtb3J5IGZlbmNlKFNZ
TkMpIGF0IGJyYW5jaC10YXJnZXQoaWYgaXRzIHRhcmdldCBpcyBub3QgYmV0d2VlbiBMTC9TQykg
aXMgbmVlZGVkIGZvciAzQTEwMDAgYW5kIDNBMzAwMC4NCg0KT3VyIHByb2Nlc3NvciBpcyBjb250
aW51YWxseSBldm9sdmluZyBhbmQgd2UgYWltIHRvIHRvIHJlbW92ZSBhbGwgdGhlc2Ugd29ya2Fy
b3VuZC1TWU5DcyBhcm91bmQgTEwvU0MgZm9yIG5ldy1jb21lIHByb2Nlc3Nvci4gDQoNCuWMl+S6
rOW4gua1t+a3gOWMuuS4reWFs+adkeeOr+S/neenkeaKgOekuuiMg+Wbrem+meiKr+S6p+S4muWb
rTLlj7fmpbwgMTAwMDk155S16K+dOiArODYgKDEwKSA2MjU0NjY2OOS8oOecnzogKzg2ICgxMCkg
NjI2MDA4MjZ3d3cubG9vbmdzb24uY27mnKzpgq7ku7blj4rlhbbpmYTku7blkKvmnInpvpnoiq/k
uK3np5HmioDmnK/mnInpmZDlhazlj7jnmoTllYbkuJrnp5jlr4bkv6Hmga/vvIzku4XpmZDkuo7l
j5HpgIHnu5nkuIrpnaLlnLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLk
u7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7l
hajpg6jmiJbpg6gg5YiG5Zyw5rOE6Zyy44CB5aSN5Yi25oiW5pWj5Y+R77yJ5pys6YKu5Lu25Y+K
5YW26ZmE5Lu25Lit55qE5L+h5oGv44CC5aaC5p6c5oKo6ZSZ5pS25pys6YKu5Lu277yM6K+35oKo
56uL5Y2z55S16K+d5oiW6YKu5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pys6YKu5Lu244CC
IA0KDQpUaGlzIGVtYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwg
aW5mb3JtYXRpb24gZnJvbSBMb29uZ3Nvbg0KVGVjaG5vbG9neSBDb3Jwb3JhdGlvbiBMaW1pdGVk
LCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eQ0Kd2hvc2Ug
YWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRh
aW5lZCBoZXJlaW4gaW4NCmFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBsaW1pdGVkIHRvLCB0
b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsDQpyZXByb2R1Y3Rpb24gb3IgZGlzc2VtaW5hdGlv
bikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykNCmlzIHBy
b2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3Rp
ZnkgdGhlIHNlbmRlciBieQ0KcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBp
dC4g
