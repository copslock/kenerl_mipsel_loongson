Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 17:06:40 +0100 (CET)
Received: from shards.monkeyblade.net ([184.105.139.130]:54822 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992160AbdBHQGdpFuko (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 17:06:33 +0100
Received: from localhost (unknown [38.140.131.194])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E355D1216F678;
        Wed,  8 Feb 2017 07:07:28 -0800 (PST)
Date:   Wed, 08 Feb 2017 11:06:26 -0500 (EST)
Message-Id: <20170208.110626.346978547122180233.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        target-devel@vger.kernel.org, andrew@lunn.ch,
        anna.schumaker@netapp.com, derek.chickles@caviumnetworks.com,
        felix.manlunas@caviumnetworks.com, bfields@fieldses.org,
        jlayton@poochiereds.net, jirislaby@gmail.com, kvalo@codeaurora.org,
        mcgrof@do-not-panic.com, madalin.bucur@nxp.com,
        UNGLinuxDriver@microchip.com, nab@linux-iscsi.org,
        mickflemm@gmail.com, nicolas.ferre@atmel.com,
        raghu.vatsavayi@caviumnetworks.com, ralf@linux-mips.org,
        satananda.burla@caviumnetworks.com,
        thomas.petazzoni@free-electrons.com, timur@codeaurora.org,
        trond.myklebust@primarydata.com,
        vivien.didelot@savoirfairelinux.com, woojung.huh@microchip.com
Subject: Re: [PATCH net-next v2 00/12] net: dsa: remove unnecessary phy.h
 include
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20170207230305.18222-1-f.fainelli@gmail.com>
References: <20170207230305.18222-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 Feb 2017 07:07:31 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

RnJvbTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQpEYXRlOiBUdWUs
ICA3IEZlYiAyMDE3IDE1OjAyOjUzIC0wODAwDQoNCj4gSSdtIGhvcGluZyB0aGlzIGRvZXNuJ3Qg
Y29uZmxpY3Qgd2l0aCB3aGF0J3MgYWxyZWFkeSBpbiBuZXQtbmV4dC4uLg0KPiANCj4gRGF2aWQs
IHRoaXMgc2hvdWxkIHByb2JhYmx5IGdvIHZpYSB5b3VyIHRyZWUgY29uc2lkZXJpbmcgdGhlIGRp
ZmZzdGF0Lg0KDQpJIHRoaW5rIHlvdSBuZWVkIG9uZSBtb3JlIHJlc3Bpbi4gIEFyZSB5b3UgZG9p
bmcgYW4gYWxsbW9kY29uZmlnIGJ1aWxkPw0KSWYgbm90LCBmb3Igc29tZXRoaW5nIGxpa2UgdGhp
cyBpdCdzIGEgbXVzdDoNCg0KZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL3dpbDYyMTAvY2ZnODAy
MTEuYzoyNDozMDogZXJyb3I6IGV4cGVjdGVkIKEpoiBiZWZvcmUgoWJvb2yiDQogbW9kdWxlX3Bh
cmFtKGRpc2FibGVfYXBfc21lLCBib29sLCAwNDQ0KTsNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4NCmRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC93aWw2MjEwL2NmZzgwMjExLmM6MjU6
MzQ6IGVycm9yOiBleHBlY3RlZCChKaIgYmVmb3JlIHN0cmluZyBjb25zdGFudA0KIE1PRFVMRV9Q
QVJNX0RFU0MoZGlzYWJsZV9hcF9zbWUsICIgbGV0IHVzZXIgc3BhY2UgaGFuZGxlIEFQIG1vZGUg
U01FIik7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KTGlrZSBsaWtlIHRo
YXQgZmlsZSBuZWVkcyBsaW51eC9tb2R1bGUuaCBpbmNsdWRlZC4NCg0KVGhhbmtzLg0K
