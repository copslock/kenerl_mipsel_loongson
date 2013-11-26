Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Nov 2013 01:45:14 +0100 (CET)
Received: from mail-pb0-f45.google.com ([209.85.160.45]:52619 "EHLO
        mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831301Ab3KZApLxOxQ8 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Nov 2013 01:45:11 +0100
Received: by mail-pb0-f45.google.com with SMTP id rp16so6883447pbb.4
        for <multiple recipients>; Mon, 25 Nov 2013 16:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:from:content-type:message-id:date:cc
         :content-transfer-encoding:to;
        bh=BUuGooKyVBY+FuTNjECa8PX8f9FHe5ca0+Yh4yfgeRc=;
        b=DcM+8MTiPJI9EL1KevkCCY8vGU1W4AAr2/4x8E873inGG/k07Q6I8dWDTUni2fdzgA
         TM+DP/Cm4SAW09KtKcEZvdcia+kBV7zav0DaHUUdxnkzWJcaoEcozadiU8SbgJmNZbsk
         1ep/fbFpTagjMzQN8oZ9cHHBbxnKyF8xRrpsFwPpDWfX+W4ohkYLE/JUxHvpNglMz039
         VWXkJ9g+cFbKuGQSQbI9+RA/5WLXhJp+8cj9bYckzq/b99CNFCzgweLHVjAvrhp72PGN
         /S7cj1BcdCLNznWnGUOvHxQ0PkIp7LOzmsGF/Km9rUy3J7HuI21kWc/xu0u1CkmFyx8Z
         932g==
X-Received: by 10.68.125.198 with SMTP id ms6mr20605243pbb.98.1385426704906;
        Mon, 25 Nov 2013 16:45:04 -0800 (PST)
Received: from [172.25.242.161] ([122.194.2.153])
        by mx.google.com with ESMTPSA id gf5sm76177365pbc.22.2013.11.25.16.45.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 16:45:03 -0800 (PST)
Subject: Users pace crash on Netlogic XLP II processors
Mime-Version: 1.0 (1.0)
From:   Jacky <cao.zhong1@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
X-Mailer: iPhone Mail (10B329)
Message-Id: <B87042C0-FFC6-4B72-8A6A-09A3BD75F5E4@gmail.com>
Date:   Tue, 26 Nov 2013 08:44:56 +0800
Cc:     "ralf@linux-mips.org" <ralf@linux-mips.org>
Content-Transfer-Encoding: 8BIT
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Return-Path: <cao.zhong1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cao.zhong1@gmail.com
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

Recently I experienced user space crash on kernel 2.6.32 after executables and memory foot print grow over particular size. As I found the crash reason is inconsistent I-cache which the code is correct in memory (or L2) but definitely wrong in L1 I-cache.

Should I-cache invalidate happen during page reclaim? And Which cache flush hook responsible for it? The work around is ugly need invalidate I cache on every page fill.
From eunb.song@samsung.com Wed Nov 27 01:29:26 2013
Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Nov 2013 01:29:28 +0100 (CET)
Received: from mailout1.samsung.com ([203.254.224.24]:24027 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6867253Ab3K0A30MLvaO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Nov 2013 01:29:26 +0100
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWW0020EC0UQ0B0@mailout1.samsung.com> for
 linux-mips@linux-mips.org; Wed, 27 Nov 2013 09:29:18 +0900 (KST)
Received: from epcpsbgx3.samsung.com ( [203.254.230.43])
        by epcpsbgr2.samsung.com (EPCPMTA) with SMTP id A5.AC.18301.CDC35925; Wed,
 27 Nov 2013 09:29:16 +0900 (KST)
X-AuditID: cbfee68e-b7f7e6d00000477d-f8-52953cdc96f3
Received: from epextmailer01 ( [203.254.219.151])
        by epcpsbgx3.samsung.com (EPCPMTA) with SMTP id A2.79.08292.CDC35925; Wed,
 27 Nov 2013 09:29:16 +0900 (KST)
Date:   Wed, 27 Nov 2013 00:29:16 +0000 (GMT)
From:   Eunbong Song <eunb.song@samsung.com>
Subject: Fwd: [PATCH] MIPS: Kill CONFIG_MTD_PARTITIONS
To:     "ralf@linux-mips.org" <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20131127002831652@eunb.song
Msgkey: 20131127002831652@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20131127002449789@eunb.song
X-ParentMTR: 20131127002449789@eunb.song
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <18399894.77721385512155579.JavaMail.weblogic@epml11>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e+Ztu4dm6lBBpu/yFlMmDqJ3YHR4+jK
        tUwBjFFcNimpOZllqUX6dglcGbu28RXcsqvY9baLqYGxw7aLkZNDSEBFouX/d0YQW0LAROLH
        jGYWCFtM4sK99WxdjFxANcsYJebfes8GU7R3/TsmiMR8RonPzW/BEiwCqhI7F00Bm8QmoC3x
        48BVZhBbWMBMYvq820wgtoiAvsT/c2/ZQWxmgRqJ7r+LGSGukJeYfPoyWJxXQFDi5MwnUFco
        SWw7NYMJIq4MVPOIGSIuITFr+gVWCJtXYkb7U6h6OYlpX9dA1UhLnJ+1gRHmm8XfH0PF+SWO
        3d4BNJMDrPfJ/WCYMbs3f4H6UUBi6pmDUK3qEgveTYRq1ZT4sXY13Jhdp5Yzw/Te3zKXCeIt
        RYkp3Q+hXtSS+PJjHxu6t3gFHCUuXL3NOIFReRaS1Cwk7bOQtCOrWcDIsopRNLUguaA4Kb3I
        SK84Mbe4NC9dLzk/dxMjJDH07WC8ecD6EGMyMEomMkuJJucDE0teSbyhsZmRhamJqbGRuaUZ
        acJK4ryLHiYFCQmkJ5akZqemFqQWxReV5qQWH2Jk4uCUamBs3/7Ox9np8id3R7GGi8uf1rdu
        jecKDO9af2hSi/2rWdc80t5l9r843HupoPK49OvXMg6dQYuuOQccEwkM3j6x54qE6QHV6StP
        q1+Y37DmmcnhY8aL/21d0uJqeapV7MW+ZNNLdydHRsbNeinQlmwWpL7n2eV/Iflnf05wXr4j
        IOGN5e3ZW11FlFiKMxINtZiLihMBlqBNtyIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42I5/e/2dN07NlODDCZulrKYMHUSuwOjx9GV
        a5kCGKMybDJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        pioplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJWijQyM9YxMTfSMjA30TAxirQwNDIxMgaoS
        MjJ2beMruGVXsettF1MDY4dtFyMnh5CAikTL/++MILaEgInE3vXvmCBsMYkL99azdTFyAdXM
        Z5T43PyWDSTBIqAqsXPRFLAGNgFtiR8HrjKD2MICZhLT590GaxYR0Jf4f+4tO4jNLFAj0f13
        MSPEMnmJyacvg8V5BQQlTs58wgKxTEli26kZTBBxZaCaR8wQcQmJWdMvsELYvBIz2p9C1ctJ
        TPu6BqpGWuL8rA2MMEcv/v4YKs4vcez2DqCZHGC9T+4Hw4zZvfkLG4QtIDH1zEGoVnWJBe8m
        QrVqSvxYuxpuzK5Ty5lheu9vmcsE8ZaixJTuh1Avakl8+bGPDd1bvAKOEheu3macwCg3C0lq
        FpL2WUjakdUsYGRZxSiaWpBcUJyUXmGsV5yYW1yal66XnJ+7iRGcop4t3sH4/7z1IUYBDkYl
        Ht4Jl6cECbEmlhVX5h5ilOBgVhLhNVWYGiTEm5JYWZValB9fVJqTWnyIMRkYgROZpUST84Hp
        M68k3tDYwNjQ0NLcwNTQyII0YSVx3vhbSUFCAumJJanZqakFqUUwW5g4OKUaGJv3vpjcHCIv
        3l6VaXNlh8/KuO6k1cra++Ujel715teLz5p1pjXuK28Id5d57U+/K55Xt1lsefp24sb5r8tc
        M6pMMiwi9X/fatrmuyfu53E+8dWdftP9oz/0n7Q+cJrFXOhETvGO2gOBpqFPC+NXd7l+41p8
        /EdO1snLsiGRenzNav5PCwtzlViKMxINtZiLihMBcNgF7JUDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eunb.song@samsung.com
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
Content-Length: 7921
Lines: 105

VGhpcyBwYXRjaCByZW1vdmVzIENPTkZJR19NVERfUEFSVElUSU9OUyBpbiBjb25maWcgZmlsZXMg
Zm9yIE1JUFMuDQogQmVjYXVzZSBDT05GSUdfTVREX1BBUlRJVElPTlMgd2FzIHJlbW92ZWQgYnkg
Y29tbWl0IDZhOGE5OGIyMmIxMGYxNTYwZDVmOTBhZGVkNGE1NDIzNGI5YjI3MjQuDQoNCg0KU2ln
bmVkLW9mZi1ieTogRXVuYm9uZyBTb25nIDxldW5iLnNvbmdAc2Ftc3VuZy5jb20+DQotLS0NCiBh
cmNoL21pcHMvY29uZmlncy9hcjdfZGVmY29uZmlnICAgICAgICAgICAgfCAgICAxIC0NCiBhcmNo
L21pcHMvY29uZmlncy9iY200N3h4X2RlZmNvbmZpZyAgICAgICAgfCAgICAxIC0NCiBhcmNoL21p
cHMvY29uZmlncy9iY202M3h4X2RlZmNvbmZpZyAgICAgICAgfCAgICAxIC0NCiBhcmNoL21pcHMv
Y29uZmlncy9jb2JhbHRfZGVmY29uZmlnICAgICAgICAgfCAgICAxIC0NCiBhcmNoL21pcHMvY29u
Zmlncy9ncHJfZGVmY29uZmlnICAgICAgICAgICAgfCAgICAxIC0NCiBhcmNoL21pcHMvY29uZmln
cy9qbXIzOTI3X2RlZmNvbmZpZyAgICAgICAgfCAgICAxIC0NCiBhcmNoL21pcHMvY29uZmlncy9s
YXNhdF9kZWZjb25maWcgICAgICAgICAgfCAgICAxIC0NCiBhcmNoL21pcHMvY29uZmlncy9tYXJr
ZWluc19kZWZjb25maWcgICAgICAgfCAgICAxIC0NCiBhcmNoL21pcHMvY29uZmlncy9tdHgxX2Rl
ZmNvbmZpZyAgICAgICAgICAgfCAgICAxIC0NCiBhcmNoL21pcHMvY29uZmlncy9wbng4MzM1X3N0
YjIyNV9kZWZjb25maWcgfCAgICAxIC0NCiBhcmNoL21pcHMvY29uZmlncy9yYjUzMl9kZWZjb25m
aWcgICAgICAgICAgfCAgICAxIC0NCiBhcmNoL21pcHMvY29uZmlncy9yYnR4NDl4eF9kZWZjb25m
aWcgICAgICAgfCAgICAxIC0NCiAxMiBmaWxlcyBjaGFuZ2VkLCAwIGluc2VydGlvbnMoKyksIDEy
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2NvbmZpZ3MvYXI3X2RlZmNv
bmZpZyBiL2FyY2gvbWlwcy9jb25maWdzL2FyN19kZWZjb25maWcNCmluZGV4IDgwZTAxMmYuLjMy
MDc3MmMgMTAwNjQ0DQotLS0gYS9hcmNoL21pcHMvY29uZmlncy9hcjdfZGVmY29uZmlnDQorKysg
Yi9hcmNoL21pcHMvY29uZmlncy9hcjdfZGVmY29uZmlnDQpAQCAtODYsNyArODYsNiBAQCBDT05G
SUdfTUFDODAyMTFfUkNfREVGQVVMVF9QSUQ9eQ0KIENPTkZJR19VRVZFTlRfSEVMUEVSX1BBVEg9
Ii9zYmluL2hvdHBsdWciDQogIyBDT05GSUdfRklSTVdBUkVfSU5fS0VSTkVMIGlzIG5vdCBzZXQN
CiBDT05GSUdfTVREPXkNCi1DT05GSUdfTVREX1BBUlRJVElPTlM9eQ0KIENPTkZJR19NVERfQ0hB
Uj15DQogQ09ORklHX01URF9CTE9DSz15DQogQ09ORklHX01URF9DRkk9eQ0KZGlmZiAtLWdpdCBh
L2FyY2gvbWlwcy9jb25maWdzL2JjbTQ3eHhfZGVmY29uZmlnIGIvYXJjaC9taXBzL2NvbmZpZ3Mv
YmNtNDd4eF9kZWZjb25maWcNCmluZGV4IDRjYThlNWMuLmYzMWQxN2IgMTAwNjQ0DQotLS0gYS9h
cmNoL21pcHMvY29uZmlncy9iY200N3h4X2RlZmNvbmZpZw0KKysrIGIvYXJjaC9taXBzL2NvbmZp
Z3MvYmNtNDd4eF9kZWZjb25maWcNCkBAIC0yNzIsNyArMjcyLDYgQEAgQ09ORklHX0ZXX0xPQURF
Uj1tDQogQ09ORklHX0NPTk5FQ1RPUj1tDQogQ09ORklHX01URD15DQogQ09ORklHX01URF9DT05D
QVQ9eQ0KLUNPTkZJR19NVERfUEFSVElUSU9OUz15DQogQ09ORklHX01URF9DSEFSPXkNCiBDT05G
SUdfTVREX0JMT0NLPXkNCiBDT05GSUdfTVREX0NGST15DQpkaWZmIC0tZ2l0IGEvYXJjaC9taXBz
L2NvbmZpZ3MvYmNtNjN4eF9kZWZjb25maWcgYi9hcmNoL21pcHMvY29uZmlncy9iY202M3h4X2Rl
ZmNvbmZpZw0KaW5kZXggOTE5MDA1MS4uM2ZlYzI2NCAxMDA2NDQNCi0tLSBhL2FyY2gvbWlwcy9j
b25maWdzL2JjbTYzeHhfZGVmY29uZmlnDQorKysgYi9hcmNoL21pcHMvY29uZmlncy9iY202M3h4
X2RlZmNvbmZpZw0KQEAgLTQ0LDcgKzQ0LDYgQEAgQ09ORklHX1VFVkVOVF9IRUxQRVJfUEFUSD0i
L3NiaW4vaG90cGx1ZyINCiAjIENPTkZJR19TVEFOREFMT05FIGlzIG5vdCBzZXQNCiAjIENPTkZJ
R19QUkVWRU5UX0ZJUk1XQVJFX0JVSUxEIGlzIG5vdCBzZXQNCiBDT05GSUdfTVREPXkNCi1DT05G
SUdfTVREX1BBUlRJVElPTlM9eQ0KIENPTkZJR19NVERfQ0ZJPXkNCiBDT05GSUdfTVREX0NGSV9J
TlRFTEVYVD15DQogQ09ORklHX01URF9DRklfQU1EU1REPXkNCmRpZmYgLS1naXQgYS9hcmNoL21p
cHMvY29uZmlncy9jb2JhbHRfZGVmY29uZmlnIGIvYXJjaC9taXBzL2NvbmZpZ3MvY29iYWx0X2Rl
ZmNvbmZpZw0KaW5kZXggNTQxOWFkYi4uMjNiNjY5MyAxMDA2NDQNCi0tLSBhL2FyY2gvbWlwcy9j
b25maWdzL2NvYmFsdF9kZWZjb25maWcNCisrKyBiL2FyY2gvbWlwcy9jb25maWdzL2NvYmFsdF9k
ZWZjb25maWcNCkBAIC0xOSw3ICsxOSw2IEBAIENPTkZJR19JTkVUPXkNCiAjIENPTkZJR19JUFY2
IGlzIG5vdCBzZXQNCiBDT05GSUdfVUVWRU5UX0hFTFBFUl9QQVRIPSIvc2Jpbi9ob3RwbHVnIg0K
IENPTkZJR19NVEQ9eQ0KLUNPTkZJR19NVERfUEFSVElUSU9OUz15DQogQ09ORklHX01URF9DSEFS
PXkNCiBDT05GSUdfTVREX0JMS0RFVlM9eQ0KIENPTkZJR19NVERfSkVERUNQUk9CRT15DQpkaWZm
IC0tZ2l0IGEvYXJjaC9taXBzL2NvbmZpZ3MvZ3ByX2RlZmNvbmZpZyBiL2FyY2gvbWlwcy9jb25m
aWdzL2dwcl9kZWZjb25maWcNCmluZGV4IGZiNjQ1ODkuLjhmMjE5ZGEgMTAwNjQ0DQotLS0gYS9h
cmNoL21pcHMvY29uZmlncy9ncHJfZGVmY29uZmlnDQorKysgYi9hcmNoL21pcHMvY29uZmlncy9n
cHJfZGVmY29uZmlnDQpAQCAtMTY1LDcgKzE2NSw2IEBAIENPTkZJR19ZQU09bQ0KIENPTkZJR19D
Rkc4MDIxMT15DQogQ09ORklHX01BQzgwMjExPXkNCiBDT05GSUdfTVREPXkNCi1DT05GSUdfTVRE
X1BBUlRJVElPTlM9eQ0KIENPTkZJR19NVERfQ0hBUj15DQogQ09ORklHX01URF9CTE9DSz15DQog
Q09ORklHX01URF9DRkk9eQ0KZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9jb25maWdzL2ptcjM5Mjdf
ZGVmY29uZmlnIGIvYXJjaC9taXBzL2NvbmZpZ3Mvam1yMzkyN19kZWZjb25maWcNCmluZGV4IGRi
NTcwNWUuLjliYzA4ZjIgMTAwNjQ0DQotLS0gYS9hcmNoL21pcHMvY29uZmlncy9qbXIzOTI3X2Rl
ZmNvbmZpZw0KKysrIGIvYXJjaC9taXBzL2NvbmZpZ3Mvam1yMzkyN19kZWZjb25maWcNCkBAIC0y
Miw3ICsyMiw2IEBAIENPTkZJR19JUF9QTlBfQk9PVFA9eQ0KICMgQ09ORklHX0lORVRfRElBRyBp
cyBub3Qgc2V0DQogIyBDT05GSUdfSVBWNiBpcyBub3Qgc2V0DQogQ09ORklHX01URD15DQotQ09O
RklHX01URF9QQVJUSVRJT05TPXkNCiBDT05GSUdfTVREX0NNRExJTkVfUEFSVFM9eQ0KIENPTkZJ
R19NVERfQ0hBUj15DQogQ09ORklHX01URF9DRkk9eQ0KZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9j
b25maWdzL2xhc2F0X2RlZmNvbmZpZyBiL2FyY2gvbWlwcy9jb25maWdzL2xhc2F0X2RlZmNvbmZp
Zw0KaW5kZXggZDlmM2RiMi4uMDE3OWM3ZiAxMDA2NDQNCi0tLSBhL2FyY2gvbWlwcy9jb25maWdz
L2xhc2F0X2RlZmNvbmZpZw0KKysrIGIvYXJjaC9taXBzL2NvbmZpZ3MvbGFzYXRfZGVmY29uZmln
DQpAQCAtMzEsNyArMzEsNiBAQCBDT05GSUdfSU5FVD15DQogIyBDT05GSUdfSU5FVF9ESUFHIGlz
IG5vdCBzZXQNCiAjIENPTkZJR19JUFY2IGlzIG5vdCBzZXQNCiBDT05GSUdfTVREPXkNCi1DT05G
SUdfTVREX1BBUlRJVElPTlM9eQ0KIENPTkZJR19NVERfQ0hBUj15DQogQ09ORklHX01URF9CTE9D
Sz15DQogQ09ORklHX01URF9DRkk9eQ0KZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9jb25maWdzL21h
cmtlaW5zX2RlZmNvbmZpZyBiL2FyY2gvbWlwcy9jb25maWdzL21hcmtlaW5zX2RlZmNvbmZpZw0K
aW5kZXggNjM2ZjgyYi4uNGMyYzBjNCAxMDA2NDQNCi0tLSBhL2FyY2gvbWlwcy9jb25maWdzL21h
cmtlaW5zX2RlZmNvbmZpZw0KKysrIGIvYXJjaC9taXBzL2NvbmZpZ3MvbWFya2VpbnNfZGVmY29u
ZmlnDQpAQCAtMTI0LDcgKzEyNCw2IEBAIENPTkZJR19JUDZfTkZfTUFOR0xFPW0NCiBDT05GSUdf
SVA2X05GX1JBVz1tDQogQ09ORklHX0ZXX0xPQURFUj1tDQogQ09ORklHX01URD15DQotQ09ORklH
X01URF9QQVJUSVRJT05TPXkNCiBDT05GSUdfTVREX0NNRExJTkVfUEFSVFM9eQ0KIENPTkZJR19N
VERfQ0hBUj15DQogQ09ORklHX01URF9CTE9DSz15DQpkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2Nv
bmZpZ3MvbXR4MV9kZWZjb25maWcgYi9hcmNoL21pcHMvY29uZmlncy9tdHgxX2RlZmNvbmZpZw0K
aW5kZXggOWZhOGYxNi4uNTkzOTQ2YSAxMDA2NDQNCi0tLSBhL2FyY2gvbWlwcy9jb25maWdzL210
eDFfZGVmY29uZmlnDQorKysgYi9hcmNoL21pcHMvY29uZmlncy9tdHgxX2RlZmNvbmZpZw0KQEAg
LTI0Niw3ICsyNDYsNiBAQCBDT05GSUdfQlRfSENJQlRVQVJUPW0NCiBDT05GSUdfQlRfSENJVkhD
ST1tDQogQ09ORklHX0NPTk5FQ1RPUj1tDQogQ09ORklHX01URD15DQotQ09ORklHX01URF9QQVJU
SVRJT05TPXkNCiBDT05GSUdfTVREX0NIQVI9eQ0KIENPTkZJR19NVERfQkxPQ0s9eQ0KIENPTkZJ
R19NVERfQ0ZJPXkNCmRpZmYgLS1naXQgYS9hcmNoL21pcHMvY29uZmlncy9wbng4MzM1X3N0YjIy
NV9kZWZjb25maWcgYi9hcmNoL21pcHMvY29uZmlncy9wbng4MzM1X3N0YjIyNV9kZWZjb25maWcN
CmluZGV4IGYyOTI1NzYuLmM4ODcwNjYgMTAwNjQ0DQotLS0gYS9hcmNoL21pcHMvY29uZmlncy9w
bng4MzM1X3N0YjIyNV9kZWZjb25maWcNCisrKyBiL2FyY2gvbWlwcy9jb25maWdzL3BueDgzMzVf
c3RiMjI1X2RlZmNvbmZpZw0KQEAgLTMxLDcgKzMxLDYgQEAgQ09ORklHX0lORVRfQUg9eQ0KICMg
Q09ORklHX0lQVjYgaXMgbm90IHNldA0KIENPTkZJR19VRVZFTlRfSEVMUEVSX1BBVEg9Ii9zYmlu
L2hvdHBsdWciDQogQ09ORklHX01URD15DQotQ09ORklHX01URF9QQVJUSVRJT05TPXkNCiBDT05G
SUdfTVREX0NNRExJTkVfUEFSVFM9eQ0KIENPTkZJR19NVERfQ0hBUj15DQogQ09ORklHX01URF9C
TE9DSz15DQpkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2NvbmZpZ3MvcmI1MzJfZGVmY29uZmlnIGIv
YXJjaC9taXBzL2NvbmZpZ3MvcmI1MzJfZGVmY29uZmlnDQppbmRleCBiODViMTIxLi41ZDlkNzA4
IDEwMDY0NA0KLS0tIGEvYXJjaC9taXBzL2NvbmZpZ3MvcmI1MzJfZGVmY29uZmlnDQorKysgYi9h
cmNoL21pcHMvY29uZmlncy9yYjUzMl9kZWZjb25maWcNCkBAIC0xMTQsNyArMTE0LDYgQEAgQ09O
RklHX05FVF9DTFNfSU5EPXkNCiBDT05GSUdfSEFNUkFESU89eQ0KIENPTkZJR19VRVZFTlRfSEVM
UEVSX1BBVEg9Ii9zYmluL2hvdHBsdWciDQogQ09ORklHX01URD15DQotQ09ORklHX01URF9QQVJU
SVRJT05TPXkNCiBDT05GSUdfTVREX0NIQVI9eQ0KIENPTkZJR19NVERfQkxPQ0s9eQ0KIENPTkZJ
R19NVERfQkxPQ0syTVREPXkNCmRpZmYgLS1naXQgYS9hcmNoL21pcHMvY29uZmlncy9yYnR4NDl4
eF9kZWZjb25maWcgYi9hcmNoL21pcHMvY29uZmlncy9yYnR4NDl4eF9kZWZjb25maWcNCmluZGV4
IDljYmE4NTYuLmY4YmY5YjQgMTAwNjQ0DQotLS0gYS9hcmNoL21pcHMvY29uZmlncy9yYnR4NDl4
eF9kZWZjb25maWcNCisrKyBiL2FyY2gvbWlwcy9jb25maWdzL3JidHg0OXh4X2RlZmNvbmZpZw0K
QEAgLTM1LDcgKzM1LDYgQEAgQ09ORklHX0lQX1BOUD15DQogIyBDT05GSUdfSVBWNiBpcyBub3Qg
c2V0DQogIyBDT05GSUdfV0lSRUxFU1MgaXMgbm90IHNldA0KIENPTkZJR19NVEQ9eQ0KLUNPTkZJ
R19NVERfUEFSVElUSU9OUz15DQogQ09ORklHX01URF9DTURMSU5FX1BBUlRTPXkNCiBDT05GSUdf
TVREX0NIQVI9eQ0KIENPTkZJR19NVERfQkxPQ0s9bQ0KLS0gDQoxLjcuMC40DQo=
